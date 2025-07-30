package main

import (
	"github.com/navalesnahuel/tanso/internal/vault"
)

func main() {
	if err := vault.SelectVault(); err != nil {
		panic(err)
	}
}
