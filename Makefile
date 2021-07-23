.PHONY: feedstock
feedstock:
	docker build -t feedstock-creation-action .
	docker run --rm --env-file=.env -v $(shell pwd):/github/workspace feedstock-creation-action example-feedstock/meta.yaml
