all: dangerous signed

dangerous: kde-neon-core-dangerous-amd64.tar.gz

dangerous-iso: kde-neon-core-dangerous-amd64.iso

signed: kde-neon-core-signed-amd64.tar.gz

signed-iso: kde-neon-core-signed-amd64.iso

kde-neon-core-signed-amd64.json: kde-neon-core-amd64.json
	./finalize-json.sh signed $< $@

kde-neon-core-dangerous-amd64.json: kde-neon-core-amd64.json
	./finalize-json.sh dangerous $< $@

kde-neon-core-signed-amd64.snap-list: kde-neon-core-amd64.json
	./create-snap-list.sh signed $< $@

kde-neon-core-dangerous-amd64.snap-list: kde-neon-core-amd64.json
	./create-snap-list.sh dangerous $< $@

%.model: %.json
	snap sign -k kde-neon-core-image-key $< > $@

%.img: %.model %.snap-list
	$(eval SNAPS = $(shell cat $(basename $@).snap-list))
	ubuntu-image snap --output-dir $<.build --image-size 30G \
	  $(foreach snap,$(SNAPS),--snap $(snap)) $<
	mv $<.build/pc.img $@

%.tar.gz: %.img
	tar zcvf $@ $<

%.img.xz: %.img
	echo "generate xz file"
	xz --force --threads=0 -vv $<

%.installer.img: %.img.xz
	-rm -rf output/
	cat image/install-sources.yaml.in |sed "s/@SIZE@/$(shell stat -c%s $<)/g" > image/install-sources.yaml
	cat image/core-desktop.yaml.in |sed "s/@PATH@/$</g" > image/core-desktop.yaml
	sudo ubuntu-image classic --debug -O output/ image/core-desktop.yaml
	mv output/plasma-core-desktop-22-amd64.img $@

%.iso: %.installer.img
	sudo ./create_iso.sh $<

clean:
	rm -rf *.model.build image2
	rm -f *.snap-list *.model *.img *.tar.gz *-signed-*.json *-dangerous-*.json

.PHONY: all clean dangerous signed
