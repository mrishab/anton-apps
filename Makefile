.PHONY: deploy setup restart stop start ping check-nvidia dry-run system-setup

# Target environment (defaults to anton-dev)
TARGET ?= anton-dev
INVENTORY := ansible/inventories/$(TARGET).ini
PLAYBOOK := ansible/playbook.yml
ANSIBLE := ansible-playbook -i $(INVENTORY) $(PLAYBOOK)

# Add -K to prompt for sudo password
ANSIBLE_FLAGS := --ask-become-pass

# Default apps and limits
ANSIBLE_VARS := $(if $(APPS),-e "apps=$(APPS)",)


deploy:
	$(ANSIBLE) $(ANSIBLE_FLAGS) $(ANSIBLE_VARS)

system-setup:
	$(ANSIBLE) $(ANSIBLE_FLAGS) $(ANSIBLE_VARS)

dry-run:
	$(ANSIBLE) $(ANSIBLE_FLAGS) $(ANSIBLE_VARS) --check --diff

restart:
	$(ANSIBLE) $(ANSIBLE_FLAGS) $(ANSIBLE_VARS) -e "app_state=restarted"

stop:
	$(ANSIBLE) $(ANSIBLE_FLAGS) $(ANSIBLE_VARS) -e "app_state=stopped"

start:
	$(ANSIBLE) $(ANSIBLE_FLAGS) $(ANSIBLE_VARS) -e "app_state=present"

ping:
	ansible all -i $(INVENTORY) -m ping

check-nvidia:
	ansible all -i $(INVENTORY) -a "nvidia-smi" --become
