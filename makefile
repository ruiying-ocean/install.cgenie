# Define the target directory
TARGET_DIR := $(HOME)/cgenie.muffin/genie-main

# Define the files to move
FILES := runmuffin-slurm.sh user.mak

# Default target
all: move_files

# Target to move files
move_files:
	@echo "Moving files to $(TARGET_DIR)..."
	@for file in $(FILES); do \
		if [ -f $$file ]; then \
			mv $$file $(TARGET_DIR)/ && echo "Moved $$file to $(TARGET_DIR)"; \
		else \
			echo "File $$file not found. Skipping..."; \
		fi; \
	done

# Clean target (optional, for removing moved files)
clean:
	@echo "Removing files from $(TARGET_DIR)..."
	@for file in $(FILES); do \
