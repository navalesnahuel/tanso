package config

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strings"
)

var (
	XDG_CONFIG            string
	XDG_CONFIG_TANSO      string
	XDG_CONFIG_TANSO_FILE string
)

func init() {
	homeDir, err := os.UserConfigDir()
	if err != nil {
		log.Fatal("Could not get the home dir for the user", err)
	}

	XDG_CONFIG = homeDir
	XDG_CONFIG_TANSO = XDG_CONFIG + "/tanso"
	XDG_CONFIG_TANSO_FILE = XDG_CONFIG_TANSO + "/config.yaml"

}

func GetConfig(key string) (string, error) {
	data, err := os.OpenFile(XDG_CONFIG_TANSO_FILE, os.O_RDONLY, 0777)
	if err != nil {
		return "", fmt.Errorf("Error trying to parse the config file, error: %w", err)
	}

	scanner := bufio.NewScanner(data)
	for scanner.Scan() {
		line := scanner.Text()
		line = strings.TrimSpace(line)
		lineArgs := strings.Split(line, "=")
		if len(lineArgs) != 2 {
			continue
		}

		if lineArgs[0] != key {
			continue
		}

		value := lineArgs[1]
		value = strings.TrimSpace(value)
		if value == "" {
			return "", fmt.Errorf("Error: Value for the key '%s' is not set.", key)
		}
		return value, nil
	}

	return "", fmt.Errorf("Error: Unable to find '%s' value on the config file", key)
}

func SetConfig(key, value string) error {
	data, err := os.ReadFile(XDG_CONFIG_TANSO_FILE)
	if err != nil {
		return fmt.Errorf("Error trying to open the config file, error: %w", err)
	}

	lines := strings.Split(string(data), "\n")
	found := false

	for i, l := range lines {
		l = strings.TrimSpace(l)
		if l == "" || !strings.Contains(l, "=") {
			continue
		}

		parts := strings.SplitN(l, "=", 2)
		if len(parts) != 2 {
			continue
		}

		k := strings.TrimSpace(parts[0])

		if k == key {
			lines[i] = fmt.Sprintf("%s=%s", k, value)
			found = true
			break
		}
	}

	if !found {
		newContent := fmt.Sprintf("%s\n%s=%s", string(data), key, value)
		err := os.WriteFile(XDG_CONFIG_TANSO_FILE, []byte(newContent), 0644)
		if err != nil {
			return fmt.Errorf("Error writting config file: %w", err)
		}
	} else {
		newContent := strings.Join(lines, "\n")
		err := os.WriteFile(XDG_CONFIG_TANSO_FILE, []byte(newContent), 0644)
		if err != nil {
			return fmt.Errorf("Error writting config file: %w", err)
		}
	}

	return nil
}
