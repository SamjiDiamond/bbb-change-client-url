# bbb-change-client-url

This repo is meant for users or developers in bbb community to make changing of traditional html5client to what they want as fast as possible without breaking anything.

## You have two options

    using option.sh
    using interaction.sh


## Using option.sh

```bash
# To get your current room name - 
#yq r /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml public.app.basename

git clone https://github.com/SamjiDiamond/bbb-change-client-url
cd bbb-change-client-url
. changeclient.sh -c html5client -n rommy
```


## Using interaction.sh

```bash
# To get your current room name - 
#yq r /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml public.app.basename

git clone https://github.com/SamjiDiamond/bbb-change-client-url
cd bbb-change-client-url
. interaction.sh
```


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss.

***Thanks for using this***

**Dont forget to give me a star**

## License
[MIT](https://choosealicense.com/licenses/mit/)
