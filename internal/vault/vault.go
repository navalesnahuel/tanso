package vault

import (
	"bytes"
	"fmt"
	"os/exec"
	"strings"
)

func selectVault(vaultPath string) error {
	return nil
}

func FZF() {

	cmd := exec.Command("bash", "-c", "fdfind . ~ --type d --follow | fzf")

	var out bytes.Buffer
	cmd.Stdout = &out
	cmd.Stderr = &out

	err := cmd.Run()
	if err != nil {
		fmt.Println("Cancelado o error:", err)
		return
	}

	selected := strings.TrimSpace(out.String())
	fmt.Println("Vault seleccionado:", selected)
}
