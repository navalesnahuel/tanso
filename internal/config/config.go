package config

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strings"
)

type Config struct {
	XDG_CONFIG            string
	XDG_CONFIG_TANSO      string
	XDG_CONFIG_TANSO_FILE string
	HOME_DIR              string

	VAULT_FOLDER string
	COLORSCHEME  string
	LENGUAGE     string
	ZEN          bool

	// bindings
	PREFIX                string
	SHOW_DEFINITION       string
	NOTE_FINDER           string
	VAULT_FINDER          string
	FILE_BROWSER          string
	NAVEGATE_THROUGH_TABS string
	BACKLINK_REF          string
	GREP                  string
	CMP_SELECT_NEXT       string
	CMP_SELECT_PREV       string
	CMD_CONFIRM           string
	CMP_COMPLETE          string
	SEARCH_SAME_WORD      string
}

var (
	Cfg = new(Config)
)

func init() {
	homeDir, err := os.UserConfigDir()
	if err != nil {
		log.Fatal("Could not get the home dir for the user", err)
	}

	// XDG_CONFIG
	Cfg.XDG_CONFIG = homeDir
	Cfg.HOME_DIR = homeDir

	Cfg.XDG_CONFIG_TANSO = Cfg.XDG_CONFIG + "/tanso"
	Cfg.XDG_CONFIG_TANSO_FILE = Cfg.XDG_CONFIG_TANSO + "/cfg"

	// CUSTOMIZATION
	Cfg.VAULT_FOLDER, _ = GetConfig("vault")

	// KEY-BINDINGS

}

func GetConfig(key string) (string, error) {
	data, err := os.OpenFile(Cfg.XDG_CONFIG_TANSO_FILE, os.O_RDONLY, 0777)
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
	data, err := os.ReadFile(Cfg.XDG_CONFIG_TANSO_FILE)
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
		err := os.WriteFile(Cfg.XDG_CONFIG_TANSO_FILE, []byte(newContent), 0644)
		if err != nil {
			return fmt.Errorf("Error writting config file: %w", err)
		}
	} else {
		newContent := strings.Join(lines, "\n")
		err := os.WriteFile(Cfg.XDG_CONFIG_TANSO_FILE, []byte(newContent), 0644)
		if err != nil {
			return fmt.Errorf("Error writting config file: %w", err)
		}
	}

	return nil
}
