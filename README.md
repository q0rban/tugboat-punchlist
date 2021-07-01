## Punchlist 🥊 + Tugboat 🚢 = ✨

This is a docker image for use in a [Tugboat](https://www.tugboat.qa) project to
simplify connecting your project to [Punchlist](https://punchli.st/).

To connect your Tugboat project to Punchli.st:

1. [Create a new Punchlist project](https://app.punchli.st/projects/create)
2. [Generate a Punchlist API token](https://app.punchli.st/settings#/api)
3. Create two [custom environment variables](https://docs.tugboat.qa/setting-up-services/how-to-set-up-services/custom-environment-variables/) on your Tugboat Repository settings page:
  a.`PUNCHLIST_PROJECT` with the ID of the project you created above
  b.`PUNCHLIST_TOKEN` with the Punchlist API token from above
4. Add the following `punchlist` service to your Tugboat config.yml:

```yml
services:
  ...
  punchlist:
    image: q0rban/tugboat-punchlist
    depends:
      - php
    aliases:
      - punchlist
    expose: 80
    commands:
      clone:
        - punchlist-page-create
      online:
        - punchlist-page-create
```
