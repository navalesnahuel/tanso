package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"

	"github.com/navalesnahuel/tanso/internal/setup"
)

func main() {
	XDG_CONFIG, _ := os.UserConfigDir()
	XDG_CONFIG = XDG_CONFIG + "/tanso"

	if err := setup.MigrateNvimDefaults(XDG_CONFIG); err != nil {
		log.Fatal(err)
	}

	cmd := exec.Command("nvim",
		"-u", XDG_CONFIG+"/init.lua",
		"--cmd", fmt.Sprintf("set runtimepath^=%v", XDG_CONFIG),
		XDG_CONFIG,
	)
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Run()
}
