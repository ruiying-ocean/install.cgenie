# Define the target directory
TARGET_DIR := $(HOME)/cgenie.muffin/genie-main

# Define the files to copy
FILES := runmuffin-slurm.sh user.mak .gitignore

# Default target
all: cp_files

# Target to copy files and make runmuffin-slurm.sh executable
cp_files:
	@echo "Copying files to $(TARGET_DIR)..."
	@for file in $(FILES); do \
		if [ -f $$file ]; then \
			cp -f $$file $(TARGET_DIR)/ && echo "Copied $$file to $(TARGET_DIR)"; \
			if [ $$file = "runmuffin-slurm.sh" ]; then \
				chmod +x $(TARGET_DIR)/$$file && echo "Made $$file executable"; \
			fi; \
		else \
			echo "File $$file not found. Skipping..."; \
		fi; \
	done
