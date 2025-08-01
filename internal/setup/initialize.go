package setup

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strings"

	"github.com/navalesnahuel/tanso/internal/config"
	"github.com/navalesnahuel/tanso/internal/search"
)

// runs tanso interface
func Run(execDir string) {
	cfg := config.Cfg

	if err := MigrateNvimDefaults(cfg.XDG_CONFIG_TANSO); err != nil {
		log.Fatal(err)
	}

	args := []string{
		"-u", cfg.XDG_CONFIG_TANSO + "/init.lua",
		"--cmd", fmt.Sprintf("set runtimepath^=%s", cfg.XDG_CONFIG_TANSO),
		execDir,
	}

	command := exec.Command("nvim", args...)
	command.Dir = cfg.VAULT_FOLDER

	command.Stdin = os.Stdin
	command.Stdout = os.Stdout
	command.Stderr = os.Stderr
	command.Run()
}

func NewNote(fileName string) error {
	cfg := config.Cfg

	fileName = filepath.Clean(fileName)
	fileName = strings.TrimSuffix(fileName, filepath.Ext(fileName))
	fileName = fileName + ".md"

	fullFilePath := cfg.VAULT_FOLDER + fileName

	if fileExists(fullFilePath) {
		fmt.Println("a note with the same name already exists on your vault, please use a diferent name on the next try!")
		os.Exit(0)
	}

	_, err := os.OpenFile(fullFilePath, os.O_CREATE|os.O_RDWR|os.O_SYNC, 0644)
	if err != nil {
		return fmt.Errorf("error trying to create the new note file: %w", err)
	}

	Run(fullFilePath)
	return nil
}

func OpenNote(tag string) error {
	cfg := config.Cfg

	tagName := strings.TrimSpace(tag)
	tagName = strings.TrimPrefix(tagName, "#")
	tagName = "#" + tagName

	fullFilePath := search.SearchTags(cfg.VAULT_FOLDER, tag)
	fullFilePath = cfg.VAULT_FOLDER + fullFilePath

	if !fileExists(fullFilePath) {
		fmt.Printf("the note with the name %v was not found on the vault\n", fullFilePath)
		os.Exit(0)
	}

	_, err := os.OpenFile(fullFilePath, os.O_CREATE|os.O_RDWR|os.O_SYNC, 0644)
	if err != nil {
		return fmt.Errorf("error trying to create the new note file: %w", err)
	}

	Run(fullFilePath)
	return nil
}

func ShowBacklinks(fileName string) error {
	cfg := config.Cfg

	fileName = filepath.Clean(fileName)
	fileName = strings.TrimSuffix(fileName, filepath.Ext(fileName))
	fileName = fileName + ".md"

	fullFilePath := cfg.VAULT_FOLDER + fileName

	if !fileExists(fullFilePath) {
		fmt.Printf("the note with the name %v was not found on the vault, please check if it exists\n", fullFilePath)
		os.Exit(0)
	}

	_, err := os.OpenFile(fullFilePath, os.O_CREATE|os.O_RDWR|os.O_SYNC, 0644)
	if err != nil {
		return fmt.Errorf("error trying to create the new note file: %w", err)
	}

	search.SearchBacklinks(cfg.VAULT_FOLDER, fileName)
	return nil
}

func fileExists(path string) bool {
	_, err := os.Stat(path)
	if err == nil {
		return true
	}
	if os.IsNotExist(err) {
		return false
	}
	return false
}
