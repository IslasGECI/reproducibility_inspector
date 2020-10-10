playbook:
	ansible-playbook ansible-playbook.yml

.PHONY: ping playbook

ping:
	ansible reproducibility_inspector --module-name ping --become
