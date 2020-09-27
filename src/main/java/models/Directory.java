package models;

import java.io.File;

public class Directory implements Files {
    public File directory;

    public Directory(File directory) {
        if (!(directory.isDirectory())) {
            throw new IllegalArgumentException();
        }
    }

    @Override
    public String toString() {
        return directory.getAbsolutePath();
    }

    @Override
    public File[] listFiles(){
        File[] files = directory.listFiles();
        return files;
    }
}
