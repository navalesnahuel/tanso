package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"

	"github.com/navalesnahuel/tanso/internal/config"
	"github.com/navalesnahuel/tanso/internal/setup"
)

func main() {
	if err := setup.MigrateNvimDefaults(config.XDG_CONFIG); err != nil {
		log.Fatal(err)
	}

	cmd := exec.Command("nvim",
		"-u", config.XDG_CONFIG_TANSO+"/init.lua",
		"--cmd", fmt.Sprintf("set runtimepath^=%v", config.XDG_CONFIG_TANSO),
		config.XDG_CONFIG_TANSO,
	)
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Run()
}
