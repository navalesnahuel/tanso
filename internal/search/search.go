package search

import (
	"bytes"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

func searchFolderFZF() string {
	cmd := exec.Command("bash", "-c", "fdfind . ~ --type d --follow | fzf")

	var out bytes.Buffer
	cmd.Stdout = &out
	cmd.Stderr = &out

	err := cmd.Run()
	if err != nil {
		if exitErr, ok := err.(*exec.ExitError); ok && exitErr.ExitCode() == 130 {
			fmt.Printf("fzf search of the vault was canceled by the user\n")
			os.Exit(0)
			return ""
		}
		fmt.Printf("error while trying to set the new vault, please run 'tanso vault' again to try")
		return ""
	}

	selected := strings.TrimSpace(out.String())
	return selected
}

func SearchTags(vault, tag string) string {
	script := fmt.Sprintf(`
	cd %s && 
	rg --files-with-matches --follow -F "%s" | fzf --preview 'batcat --style=numbers --color=always {} | head -100'
`, vault, tag)

	cmd := exec.Command("bash", "-c", script)
	cmd.Env = append(os.Environ(), "FZF_DEFAULT_OPTS=")

	var out bytes.Buffer
	cmd.Stdout = &out
	cmd.Stderr = &out

	err := cmd.Run()
	if err != nil {
		if exitErr, ok := err.(*exec.ExitError); ok && exitErr.ExitCode() == 130 {
			fmt.Printf("fzf search of the vault was canceled by the user\n")
			os.Exit(0)
			return ""
		}
		fmt.Printf("error while searching tags, please run 'tanso tag 'tagname'' to try again: %v\n", err.(*exec.ExitError))
		return ""
	}

	selected := strings.TrimSpace(out.String())
	return selected
}

func SearchBacklinks(vault, filename string) string {
	noteName := strings.TrimSuffix(filepath.Base(filename), filepath.Ext(filename))

	script := fmt.Sprintf(`
		cd %s &&
		rg --files-with-matches -F '[[%s]]' --glob '*.md' |
		fzf --preview 'rg --color=always -F "[[%s]]" {} || batcat --style=numbers --color=always {}'
	`, vault, noteName, noteName)

	cmd := exec.Command("bash", "-c", script)
	cmd.Env = append(os.Environ(), "FZF_DEFAULT_OPTS=")

	var out bytes.Buffer
	cmd.Stdout = &out
	cmd.Stderr = &out

	err := cmd.Run()
	if err != nil {
		if exitErr, ok := err.(*exec.ExitError); ok && exitErr.ExitCode() == 130 {
			fmt.Println("fzf search of the vault was canceled by the user")
			os.Exit(0)
			return ""
		}
		fmt.Printf("error while searching backlinks: %v\n", err)
		return ""
	}

	selected := strings.TrimSpace(out.String())
	return selected
}
