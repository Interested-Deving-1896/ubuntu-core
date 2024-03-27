all: dangerous signed

dangerous: kde-neon-core-dangerous-amd64.tar.gz

signed: kde-neon-core-signed-amd64.tar.gz

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

clean:
	rm -rf *.model.build
	rm -f *.snap-list *.model *.img *.tar.gz *-signed-*.json *-dangerous-*.json

.PHONY: all clean dangerous signed
