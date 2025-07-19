package setup

import (
	"fmt"
	"io"
	"io/fs"
	"log/slog"
	"os"
	"path/filepath"
)

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

func copyDir(src, dst string) error {
	srcStats, err := os.Stat(src)
	if err != nil {
		return fmt.Errorf("Error while trying to get the stats from src: %w", err)
	}
	if !srcStats.IsDir() {
		return fmt.Errorf("Error. src is not a directory: %w", err)
	}

	if err := os.MkdirAll(dst, os.ModePerm); err != nil {
		return fmt.Errorf("Error trying to create the dst folder: %w", err)
	}

	return filepath.WalkDir(src, func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			return fmt.Errorf("Error on the walking filepath fn: %w", err)
		}

		if d.IsDir() && d.Name() == src {
			return filepath.SkipDir
		}

		relPath, err := filepath.Rel(src, path)
		if err != nil {
			return fmt.Errorf("Error getting relative path: %w", err)
		}
		finalDst := filepath.Join(dst, relPath)

		if !d.IsDir() {
			if err := copyFile(path, finalDst); err != nil {
				return err
			}
		} else if d.IsDir() {
			if err := os.MkdirAll(finalDst, os.ModePerm); err != nil {
				return fmt.Errorf("Error trying to make the new dir while walking the filepath: %w", err)
			}
		}

		return nil
	})
}

func MigrateNvimDefaults(XDG_CONFIG string) error {
	slog.Info("Migrating tanso nvim defaults to XDG")
	XDG_CONFIG, err := os.UserConfigDir()
	if err != nil {
		return err
	}
	if err = copyDir("./embed/", XDG_CONFIG); err != nil {
		return err
	}

	slog.Info("embed tanso nvim configuration migrated to XDG Directory")
	return nil
}
