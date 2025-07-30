package vault

import (
	"bytes"
	"fmt"
	"log/slog"
	"os"
	"os/exec"
	"strings"

	"github.com/navalesnahuel/tanso/internal/config"
)

func searchFolderFZF() string {
	cmd := exec.Command("bash", "-c", "fdfind . ~ --type d --follow | fzf")

	var out bytes.Buffer
	cmd.Stdout = &out
	cmd.Stderr = &out

	err := cmd.Run()
	if err != nil {
		if exitErr, ok := err.(*exec.ExitError); ok && exitErr.ExitCode() == 130 {
			slog.Info("fzf search of the vault was canceled by the user")
			os.Exit(0)
			return ""
		}
		slog.Error("Error while trying to set the new vault, please run 'tanso vault' again to try", "error", err)
		return ""
	}

	selected := strings.TrimSpace(out.String())
	return selected
}

func SelectVault() error {
	vault := searchFolderFZF()
	if vault == "" {
		return fmt.Errorf("Error: Something went wrong while selecting the vault, please run 'tanso vault' again")
	}
	if err := config.SetConfig("vault", vault); err != nil {
		return fmt.Errorf("Error: Something went wrong trying to set the new vault on the config: %w", err)
	}
	return nil

}
