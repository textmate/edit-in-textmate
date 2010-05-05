NAME         = Edit\ in\ TextMate
DST          = /tmp/$(NAME)
DST_BUNDLE   = $(DST)/$(NAME).bundle
DST_CONTENTS = $(DST_BUNDLE)/Contents
DST_BIN      = $(DST_CONTENTS)/MacOS
DST_RSRC     = $(DST_CONTENTS)/Resources
DST_LANG     = $(DST_RSRC)/English.lproj

CFLAGS  = -pipe -fPIC -Os -DNDEBUG
CFLAGS += -m32 -mmacosx-version-min=10.5 -isysroot /Developer/SDKs/MacOSX10.5.sdk
CFLAGS += -funsigned-char -fvisibility=hidden
CFLAGS += -DNS_BUILD_32_LIKE_64
CFLAGS += -Wall -Wwrite-strings -Wformat=2 -Winit-self -Wmissing-include-dirs -Wno-parentheses -Wno-sign-compare -Wno-switch

all: $(DST)/Info $(DST_CONTENTS)/Info.plist $(DST_BIN)/$(NAME) $(DST_LANG)/InfoPlist.strings $(DST_RSRC)/url\ map.plist

$(DST):          ;                mkdir '$@'
$(DST_BUNDLE):   $(DST);          mkdir '$@'
$(DST_CONTENTS): $(DST_BUNDLE);   mkdir '$@'
$(DST_BIN):      $(DST_CONTENTS); mkdir '$@'
$(DST_RSRC):     $(DST_CONTENTS); mkdir '$@'
$(DST_LANG):     $(DST_RSRC);     mkdir '$@'

$(DST)/Info:                   rsrc/Info              $(DST);          cp '$<' '$@'
$(DST_CONTENTS)/Info.plist:    rsrc/Info.plist        $(DST_CONTENTS); cp '$<' '$@'
$(DST_LANG)/InfoPlist.strings: rsrc/InfoPlist.strings $(DST_LANG);     cp '$<' '$@'
$(DST_RSRC)/url\ map.plist:    rsrc/url\ map.plist    $(DST_RSRC);     cp '$<' '$@'

$(DST_BIN)/$(NAME): src/Edit\ in\ TextMate.mm $(DST_BIN)
	g++ -bundle $(CFLAGS) -o '$@' src/*.mm -framework Cocoa -framework Carbon -framework WebKit

install: $(DST_BIN)/$(NAME)
	cp -pR $(DST) /Library/InputManagers/$(NAME) && chown -R root /Library/InputManagers/$(NAME)

uninstall:
	rm -rf /Library/InputManagers/$(NAME)

clean:
	rm -rf $(DST)

.PHONY: all clean install uninstall
