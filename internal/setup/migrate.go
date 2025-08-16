package setup

import (
	"embed"
	"fmt"
	"io"
	"io/fs"
	"os"
	"path/filepath"
)

//go:embed embed/*
var embeddedFiles embed.FS

func copyFile(src, dst string) error {
	srcFile, err := os.Open(src)
	if err != nil {
		return fmt.Errorf("Error trying to open the src file: %w", err)
	}
	defer srcFile.Close()

	dstFile, err := os.OpenFile(dst, os.O_CREATE|os.O_RDWR, os.ModePerm)
	if err != nil {
		return fmt.Errorf("Error trying to open the dst file: %w", err)
	}
	defer dstFile.Close()

	_, err = io.Copy(dstFile, srcFile)
	if err != nil {
		return fmt.Errorf("Error trying to copy the src into dst: %w", err)
	}

	return nil
}

func copyDir(srcFS fs.FS, src, dst string) error {
	return fs.WalkDir(srcFS, src, func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			return fmt.Errorf("Error walking FS: %w", err)
		}

		relPath, err := filepath.Rel(src, path)
		if err != nil {
			return fmt.Errorf("Error getting relative path: %w", err)
		}

		finalDst := filepath.Join(dst, relPath)

		if d.IsDir() {
			return os.MkdirAll(finalDst, os.ModePerm)
		}

		data, err := fs.ReadFile(srcFS, path)
		if err != nil {
			return fmt.Errorf("Error reading file: %w", err)
		}

		if err := os.MkdirAll(filepath.Dir(finalDst), os.ModePerm); err != nil {
			return fmt.Errorf("Error creating dir: %w", err)
		}

		return os.WriteFile(finalDst, data, os.ModePerm)
	})
}

func MigrateNvimDefaults(XDG_CONFIG string) error {
	_, err := os.Stat(XDG_CONFIG + "/init.lua")
	if err != nil {
		return copyDir(embeddedFiles, "embed", XDG_CONFIG)
	}

	return nil
}
