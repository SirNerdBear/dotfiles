#!/usr/bin/env bash

# Manually Installed apps
# Adobe Photoshop
# Adobe Illustrator
# Adobe Acrobat DC
# Adobe InDesign
# Artstudio Pro
# Pop Dot Comics
# CleanMyMac X
#   -- Also need to add ~/Library/Caches/antibody to ignore list
# Sidify Apple Music Converter

brew tap caskroom/cask

brew cask install java #needed for arduno and others
brew cask install arduino #dev IDE used for compiling within NeoVIM/VSCode

##################################################################################
# iTerm2  — Terminal replacement
##################################################################################
brew cask install iterm2 #terminal replacement
defaults write com.googlecode.iterm2 PrefsCustomFolder "${HOME}/.config"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -int 1


##################################################################################
# Alfred 3 — GUI fuzzy finder and more (replaces spotlight interface)
##################################################################################
brew cask install alfred
defaults write com.runningwithcrayons.Alfred-Preferences syncfolder "${HOME}/.config"
! $(pgrep -q "Alfred 4") && open /Applications/Alfred\ 4.app
#TODO copy license file... how?
#~/Library/ApplicationSupport/Alfred
#license.FVFXV2AZHV2H.plist
#not sure if this will work since it may need activation

brew cask install dropbox 
brew cask install google-drive



brew cask install visual-studio-code #VSCode is a GUI text editor (not used much anymore)
brew cask install discord #Chatting sexyness
#brew cask install scrivener #Writing prose. Must manually install until I get 3.0 (assholes)

#canary chrome
brew cask install google-chrome
#opera
brew cask install firefox

brew cask install imageoptim #Reduce size of images https://imageoptim.com/mac
brew cask install imagealpha #PNG24 to PNG8 with alpha channel support https://pngmini.com/ 


brew cask install docker #containers are sexy

brew cask install kindle 
#brew cask install monolingual #Reduce HDD waste by removing unused lanaugages
brew cask install sketch 
brew cask install sketch-toolbox
brew cask install soulver #Text driven calcuations on-the-fly
brew cask install transmit #For the occational FTP need
brew cask install vlc #Playing videos and such
brew cask install karabiner-elements #key remapping
brew cask install virtualbox #vms

brew tap homebrew/completions
brew install homebrew/completions/docker-completion
brew install homebrew/completions/docker-compose-completion



brew tap homebrew/cask-fonts 
#not sure why but ligatures don't work with font-firacode-nerd-font-mono
#so utilizing the non-acsii font for iTerm to support ligatures AND powerline+ symbols
brew cask install font-fira-code #ligature font for development sexyness
brew cask install font-firacode-nerd-font #nerdfont support (includes powerline and many others)

#install a whole bunch of non-restrictive license fonts
brew cask install
	font-permanent-marker \
	font-indie-flower \
	font-text-me-one \
	font-contrail-one \
	font-krona-one \
	font-noto-emoji \
	font-esteban \
	font-advent-pro \
	font-oldenburg \
	font-opendyslexic \
	font-warnes \
	font-tenor-sans \
	font-piedra \
	font-courier-new \
	font-damion \
	font-coming-soon \
	font-chango \
	font-shanti \
	font-supermercado-one \
	font-mako \
	font-fjalla-one \
	font-mr-bedfort \
	font-gilda-display \
	font-karla-tamil-inclined \
	font-knewave \
	font-abel \
	font-londrina-outline \
	font-lalezar \
	font-unica-one \
	font-cagliostro \
	
	font-unkempt \
	font-noto-serif \
	font-marmelad \
	font-lusitana \
	font-sofadi-one \
	font-geostar \
	font-smythe \
	font-barlow \
	font-wenquanyi-zen-hei \
	font-sancreek \
	font-benchnine \
	font-rochester \
	font-lobster-two \
	font-averia-gruesa-libre \
	font-rozha-one \
	font-fruktur \
	font-germania-one \
	font-bubbler-one \
	font-oskidakelh \
	font-seymour-one \
	font-ranchers \
	font-tulpen-one \
	font-gveret-levin \
	font-coustard \
	font-handlee \
	font-lustria \
	font-petit-formal-script \
	font-xkcd \
	font-leckerli-one \
	font-migmix-2m \
	font-tex-gyre-termes \
	font-stoke \
	font-doppio-one \
	font-italianno \
	font-freehand \
	font-namdhinggo-sil \
	font-fresca \
	font-twitter-color-emoji \
	font-space-mono \
	font-iosevka-slab \
	font-cutive \
	font-linux-libertine \
	font-encodesans-semiexpanded \
	font-silent-lips \
	font-volkhov \
	font-playball \
	font-butcherman \
	font-signika-negative \
	font-antic \
	font-almendra \
	font-encodesans-expanded \
	font-adamina \
	font-goblin-one \
	font-lancelot \
	font-kaushan-script \
	font-rokkitt \
	font-diplomata-sc \
	font-league-gothic \
	font-allerta-stencil \
	font-tex-gyre-pagella-math \
	font-skranji \
	font-inter-ui \
	font-junge \
	font-nova-oval \
	font-nova-mono \
	font-courier-prime-code \
	font-la-belle-aurore \
	font-anonymous-pro \
	font-colus \
	font-oxygen-mono \
	font-stix \
	font-inconsolata-g \
	font-ruge-boogie \
	font-swanky-and-moo-moo \
	font-iranian-serif \
	font-balthazar \
	font-karla-tamil-upright \
	font-marck-script \
	font-playfair-display \
	font-han-nom-a \
	font-snippet \
	font-amaranth \
	font-spicy-rice \
	font-rosario \
	font-yeseva-one \
	font-viga \
	font-shojumaru \
	font-jacques-francois-shadow \
	font-condiment \
	font-kelly-slab \
	font-iosevka \
	font-lisutzimu \
	font-noto-mono \
	font-keep-calm \
	font-paytone-one \
	font-happy-monkey \
	font-khmer \
	font-aileron \
	font-alegreya-sans \
	font-bokor \
	font-faster-one \
	font-tex-gyre-adventor \
	font-cutive-mono \
	font-trykker \
	font-tibetan-machine-uni \
	font-overpass \
	font-dukor \
	font-sinkin-sans \
	font-satisfy \
	font-varela-round \
	font-chapbook \
	font-source-han-code-jp \
	font-ruthie \
	font-icomoon \
	font-aubrey \
	font-scheherazade \
	font-koruri \
	font-comic-sans-ms \
	font-bigshot-one \
	font-cookie \
	font-armata \
	font-migmix-1p \
	font-digohweli-old-do \
	font-inconsolata \
	font-belgrano \
	font-oskidenes \
	font-eeyek-unicode \
	font-petrona \
	font-ultra \
	font-stalemate \
	font-margarine \
	font-gruppo \
	font-prociono \
	font-overlock-sc \
	font-press-start2p \
	font-kreon \
	font-buenard \
	font-yiddishkeit \
	font-noto-color-emoji \
	font-carme \
	font-andagii \
	font-cooper-hewitt \
	font-aleo \
	font-fontdiner-swanky \
	font-caesar-dressing \
	font-open-sans-hebrew \
	font-oleo-script-swash-caps \
	font-libre-baskerville \
	font-sarina \
	font-syncopate \
	font-genshingothic \
	font-lora \
	font-siemreap \
	font-carrois-gothic-sc \
	font-source-han-serif-sb-h \
	font-african-serif \
	font-actor \
	font-metal \
	font-buda \
	font-telex \
	font-combo \
	font-migmix-2p \
	font-corben \
	font-tex-gyre-pagella \
	font-bitstream-vera \
	font-webdings \
	font-allura \
	font-almendra-display \
	font-medula-one \
	font-inika \
	font-stint-ultra-condensed \
	font-latin-modern \
	font-waiting-for-the-sunrise \
	font-aguafina-script \
	font-monoisome \
	font-delius-swash-caps \
	font-kacstone \
	font-go-mono \
	font-edlo \
	font-rancho \
	font-cwtex-q \
	font-trocchi \
	font-arial \
	font-monoton \
	font-tienne \
	font-roboto \
	font-elsie-swash-caps \
	font-code2000 \
	font-dynalight \
	font-encodesans \
	font-cormorant \
	font-karla \
	font-voces \
	font-cantarell \
	font-maiden-orange \
	font-erica-one \
	font-purple-purse \
	font-mystery-quest \
	font-love-ya-like-a-sister \
	font-battambang \
	font-latin-modern-math \
	font-vibur \
	font-andada-sc \
	font-questrial \
	font-average-sans \
	font-days-one \
	font-allerta \
	font-courier-prime-medium-and-semi-bold \
	font-kalam \
	font-michroma \
	font-geo \
	font-homenaje \
	font-adinatha-tamil-brahmi \
	font-odor-mean-chey \
	font-humor-sans \
	font-profontx \
	font-devonshire \
	font-flamenco \
	font-squada-one \
	font-galdeano \
	font-berkshire-swash \
	font-karma \
	font-ionicons \
	font-moulpali \
	font-roboto-mono \
	font-domine \
	font-alex-brush \
	font-gentium-book-basic \
	font-donegal-one \
	font-nexa-rust \
	font-fanwood-text \
	font-eagle-lake \
	font-dosis \
	font-skola-sans \
	font-belleza \
	font-arimo \
	font-englebert \
	font-jim-nightshade \
	font-penuturesu \
	font-stardos-stencil \
	font-everson-mono \
	font-laila \
	font-yellowtail \
	font-metamorphous \
	font-share \
	font-habibi \
	font-vt323 \
	font-pt-mono \
	font-work-sans \
	font-schoolbell \
	font-bf-tiny-hand \
	font-carter-one \
	font-niconne \
	font-fenix \
	font-forum \
	font-audiowide \
	font-euphoria-script \
	font-macondo \
	font-exo \
	font-pt-serif \
	font-bigelow-rules \
	font-mouse-memoirs \
	font-antic-didone \
	font-wakor \
	font-impact \
	font-crafty-girls \
	font-mfizz \
	font-original-surfer \
	font-input \
	font-charter \
	font-uncial-antiqua \
	font-computer-modern \
	font-meslo-lg \
	font-inconsolata-dz \
	font-oxygen \
	font-dana-yad \
	font-alike \
	font-gnu-unifont \
	font-rambla \
	font-digohweli \
	font-saira \
	font-monoid \
	font-px437-pxplus \
	font-comfortaa \
	font-crushed \
	font-fascinate \
	font-montserrat-subrayada \
	font-angkor \
	font-hanamina \
	font-allan \
	font-orbitron \
	font-acme \
	font-ubuntu \
	font-nova-cut \
	font-glober \
	font-verdana \
	font-preahvihear \
	font-noto-sans-display \
	font-grand-hotel \
	font-antinoou \
	font-sniglet \
	font-emblema-one \
	font-sintony \
	font-ewert \
	font-kopub \
	font-amiri \
	font-philosopher \
	font-oskidenea \
	font-give-you-glory \
	font-gloria-hallelujah \
	font-share-tech-mono \
	font-kisiska \
	font-awesome-terminal-fonts \
	font-marvel \
	font-macondo-swash-caps \
	font-merriweather \
	font-nova-square \
	font-homemade-apple \
	font-ligature-symbols \
	font-merienda \
	font-raleway \
	font-miltonian-tattoo \
	font-archivo-black \
	font-neucha \
	font-dawning-of-a-new-day \
	font-the-girl-next-door \
	font-fira-sans \
	font-lateef \
	font-masinahikan \
	font-source-han-serif-el-m \
	font-nova-flat \
	font-poiret-one \
	font-basic \
	font-foundation-icons \
	font-metrophobic \
	font-inconsolata-lgc \
	font-rotinonhsonni-sans \
	font-righteous \
	font-pinyon-script \
	font-share-tech \
	font-federo \
	font-sonsie-one \
	font-frijole \
	font-voltaire \
	font-fantasque-sans-mono \
	font-arapey \
	font-engagement \
	font-just-another-hand \
	font-mr-de-haviland \
	font-masinahikan-dene \
	font-pirata-one \
	font-cherry-swash \
	font-bree-serif \
	font-concert-one \
	font-news-cycle \
	font-code2001 \
	font-francois-one \
	font-federant \
	font-ricty-diminished \
	font-chicle \
	font-wenquanyi-micro-hei-lite \
	font-rouge-script \
	font-thabit \
	font-quando \
	font-calligraffitti \
	font-phetsarath \
	font-bentham \
	font-caudex \
	font-rock-salt \
	font-life-savers \
	font-arbutus-slab \
	font-arvo \
	font-bukyvede-bold \
	font-crimson-text \
	font-gentium-basic \
	font-cuprum \
	font-im-fell-english \
	font-archivo-narrow \
	font-finger-paint \
	font-passero-one \
	font-go-medium \
	font-freesans \
	font-genjyuugothic \
	font-palemonas \
	font-hasklig \
	font-playfair-display-sc \
	font-cedarville-cursive \
	font-patua-one \
	font-anka-coder \
	font-cabin-condensed \
	font-nova-slim \
	font-kayases \
	font-nova-script \
	font-imprima \
	font-vazir \
	font-racing-sans-one \
	font-sirin-stencil \
	font-spinnaker \
	font-im-fell-dw-pica \
	font-unifrakturmaguntia \
	font-nosifer \
	font-fontawesome \
	font-coda \
	font-wenquanyi-micro-hei \
	font-black-ops-one \
	font-keania-one \
	font-libre-franklin \
	font-lemon \
	font-fredericka-the-great \
	font-mate \
	font-sans-forgetica \
	font-miltonian \
	font-pontano-sans \
	font-nyashi \
	font-cabin-sketch \
	font-migu-1p \
	font-jacques-francois \
	font-doulos-sil \
	font-headland-one \
	font-istok-web \
	font-glass-antiqua \
	font-oskideneb \
	font-roboto-slab \
	font-chewy \
	font-baloo \
	font-titan-one \
	font-tex-gyre-cursor \
	font-rajdhani \
	font-poly \
	font-inder \
	font-russo-one \
	font-play \
	font-quantico \
	font-plaster \
	font-qataban \
	font-boogaloo \
	font-symbola \
	font-convergence \
	font-average \
	font-teko \
	font-noto-sans \
	font-wendy-one \
	font-monda \
	font-rammetto-one \
	font-port-lligat-sans \
	font-hanalei-fill \
	font-shadows-into-light-two \
	font-abeezee \
	font-tai-le-valentinium \
	font-hammersmith-one \
	font-kameron \
	font-noto-sans-symbols \
	font-architects-daughter \
	font-qwigley \
	font-creepster \
	font-nanumgothic \
	font-wire-one \
	font-luckiest-guy \
	font-anton \
	font-nixie-one \
	font-slackey \
	font-idealist-sans \
	font-wellfleet \
	font-anaheim \
	font-bevan \
	font-mate-sc \
	font-genjyuugothic-x \
	font-sunshiney \
	font-fzshusong-z01 \
	font-irish-grover \
	font-bitter \
	font-didact-gothic \
	font-coda-caption \
	font-aladin \
	font-lato \
	font-devicons \
	font-alef \
	font-underdog \
	font-lilita-one \
	font-conakry \
	font-bungee \
	font-code \
	font-code2002 \
	font-bukyvede-italic \
	font-snowburst-one \
	font-open-sans \
	font-libertinus \
	font-alice \
	font-ribeye-marrow \
	font-monofett \
	font-fredoka-one \
	font-arbutus \
	font-ropa-sans \
	font-ceviche-one \
	font-yanone-kaffeesatz \
	font-nova-round \
	font-amarante \
	font-office-code-pro \
	font-quattrocento \
	font-tex-gyre-termes-math \
	font-cantora-one \
	font-nanumgothiccoding \
	font-myricam \
	font-flavors \
	font-mrs-sheppards \
	font-redressed \
	font-sail \
	font-merienda-one \
	font-molle \
	font-rum-raisin \
	font-alegreya \
	font-norican \
	font-codystar \
	font-eater \
	font-nika \
	font-3270 \
	font-bravura \
	font-kite-one \
	font-prata \
	font-geostar-fill \
	font-canter \
	font-andika \
	font-arial-black \
	font-milonga \
	font-zeyada \
	font-vollkorn \
	font-quivira \
	font-baumans \
	font-source-code-pro \
	font-quintessential \
	font-lovers-quarrel \
	font-oskiblackfoot \
	font-amethysta \
	font-electrolize \
	font-courier-prime \
	font-gidole \
	font-proza-libre \
	font-zilla-slab \
	font-rationale \
	font-just-me-again-down-here \
	font-materialdesignicons-webfont \
	font-quattrocento-sans \
	font-exo2 \
	font-della-respira \
	font-noticia-text \
	font-langdon \
	font-averia-serif-libre \
	font-kristi \
	font-walter-turncoat \
	font-lily-script-one \
	font-vazir-code \
	font-hyppolit \
	font-tangerine \
	font-rosarivo \
	font-trirong \
	font-dhyana \
	font-covered-by-your-grace \
	font-mr-dafoe \
	font-nobile \
	font-fondamento \
	font-trebuchet-ms \
	font-italiana \
	font-bangers \
	font-josefin-sans \
	font-prince-valiant \
	font-oswald \
	font-patrick-hand-sc \
	font-courgette \
	font-tex-gyre-chorus \
	font-im-fell-dw-pica-sc \
	font-spectral \
	font-brawler \
	font-shadows-into-light \
	font-overlock \
	font-kotta-one \
	font-aldrich \
	font-signika \
	font-migu-1m \
	font-sevillana \
	font-sofia \
	font-carrois-gothic \
	font-maven-pro \
	font-bonbon \
	font-titillium-web \
	font-trade-winds \
	font-sarpanch \
	font-im-fell-great-primer \
	font-smokum \
	font-tinos \
	font-urw-base35 \
	font-tillana \
	font-bebas-neue \
	font-capriola \
	font-quicksand \
	font-cousine \
	font-hind \
	font-duru-sans \
	font-andale-mono \
	font-open-iconic \
	font-new-rocker \
	font-georgia \
	font-montez \
	font-cardo \
	font-modern-antiqua \
	font-kranky \
	font-myrica \
	font-libre-caslon-display \
	font-revalia \
	font-libre-caslon-text \
	font-orienta \
	font-miao-unicode \
	font-pitabek \
	font-khand \
	font-akronim \
	font-iceland \
	font-noto-sans-mono \
	font-chenla \
	font-nexa \
	font-astloch \
	font-ruda \
	font-dancing-script \
	font-noto-serif-display \
	font-dashicons \
	font-alike-angular \
	font-koulen \
	font-samim \
	font-vast-shadow \
	font-sacramento \
	font-xits \
	font-nokora \
	font-oskidenec \
	font-tauri \
	font-free-hk-kai \
	font-asul \
	font-unlock \
	font-constructium \
	font-passion-one \
	font-megrim \
	font-changa-one \
	font-aegean \
	font-babelstone-han \
	font-league-script \
	font-rubik \
	font-hack \
	font-asap \
	font-jsmath-cmbx10 \
	font-loved-by-the-king \
	font-junction \
	font-ruluko \
	font-migu-2m \
	font-rufina \
	font-bayon \
	font-joti-one \
	font-over-the-rainbow \
	font-noto-sans-symbols2 \
	font-marko-one \
	font-special-elite \
	font-vidaloka \
	font-strait \
	font-aclonica \
	font-sigmar-one \
	font-hanuman \
	font-metropolis \
	font-camingocode \
	font-sansita-one \
	font-bilbo \
	font-oranienbaum \
	font-londrina-solid \
	font-peralta \
	font-linden-hill \
	font-molengo \
	font-bilbo-swash-caps \
	font-comic-neue \
	font-varela \
	font-candal \
	font-oskiwest \
	font-scada \
	font-emilys-candy \
	font-chela-one \
	font-arizonia \
	font-pathway-gothic-one \
	font-trochut \
	font-josefin-slab \
	font-meddon \
	font-redacted \
	font-chivo \
	font-ia-writer-duospace \
	font-wallpoet \
	font-monofur \
	font-ostrich-sans \
	font-elsie \
	font-nunito \
	font-waltograph \
	font-source-serif-pro \
	font-baron \
	font-bad-script \
	font-kdam-thmor \
	font-parisienne \
	font-gafata \
	font-kantumruy \
	font-accordance \
	font-tex-gyre-schola \
	font-dorsa \
	font-unna \
	font-fira-mono \
	font-courier-prime-sans \
	font-tex-gyre-bonum \
	font-content \
	font-spirax \
	font-fugaz-one \
	font-ocr \
	font-miniver \
	font-prosto-one \
	font-artifika \
	font-asset \
	font-source-sans-pro \
	font-autour-one \
	font-nothing-you-could-do \
	font-fascinate-inline \
	font-rounded-m-plus \
	font-pompiere \
	font-galindo \
	font-julee \
	font-montserrat \
	font-aboriginal-sans \
	font-sadagolthina \
	font-eb-garamond \
	font-african-sans \
	font-gudea \
	font-tex-gyre-heros \
	font-oskieast \
	font-freckle-face \
	font-ledger \
	font-croissant-one \
	font-terminus \
	font-material-icons \
	font-gentium-plus \
	font-londrina-sketch \
	font-romanesco \
	font-stalinist-one \
	font-envy-code-r \
	font-charis-sil \
	font-abril-fatface \
	font-seaweed-script \
	font-butler \
	font-cabin \
	font-sorts-mill-goudy \
	font-offside \
	font-butterfly-kids \
	font-gandom \
	font-magra \
	font-im-fell-english-sc \
	font-ruslan-display \
	font-pacifico \
	font-tuffy \
	font-gochi-hand \
	font-stroke \
	font-gabriela \
	font-et-book \
	font-sarasa-gothic \
	font-bukyvede-regular \
	font-simple-line-icons \
	font-six-caps \
	font-ibm-plex \
	font-muli \
	font-henny-penny \
	font-meie-script \
	font-aboriginal-serif \
	font-miss-fajardose \
	font-cinzel-decorative \
	font-roboto-condensed \
	font-open-sans-hebrew-condensed \
	font-short-stack \
	font-clicker-script \
	font-copse \
	font-takaoex \
	font-red-october \
	font-clear-sans \
	font-alfa-slab-one \
	font-sue-ellen-francisco \
	font-d2coding \
	font-hermit \
	font-seoulhangangcondensed \
	font-dejavu-sans \
	font-amatic-sc \
	font-cambo \
	font-encodesans-semicondensed \
	font-rye \
	font-reenie-beanie \
	font-go \
	font-fauna-one \
	font-goudy-bookletter1911 \
	font-radley \
	font-new-athena-unicode \
	font-puritan \
	font-averia-sans-libre \
	font-parastoo \
	font-dr-sugiyama \
	font-halant \
	font-numans \
	font-monsieur-la-doulaise \
	font-im-fell-double-pica-sc \
	font-oregano \
	font-rupakara \
	font-junicode \
	font-ribeye \
	font-stint-ultra-expanded \
	font-neuton \
	font-crete-round \
	font-economica \
	font-times-new-roman \
	font-im-fell-great-primer-sc \
	font-glegoo \
	font-mountains-of-christmas \
	font-londrina-shadow \
	font-liberation-sans \
	font-montaga \
	font-cinzel \
	font-jaapokki \
	font-great-vibes \
	font-n-gage \
	font-im-fell-french-canon-sc \
	font-annie-use-your-telescope \
	font-vampiro-one \
	font-lekton \
	font-bowlby-one-sc \
	font-prime \
	font-paprika \
	font-poller-one \
	font-fjord-one \
	font-enriqueta \
	font-im-fell-double-pica \
	font-average-mono \
	font-mrs-saint-delafield \
	font-griffy \
	font-diplomata \
	font-sanchez \
	font-jockey-one \
	font-fairfax \
	font-chau-philomene-one \
	font-league-spartan \
	font-port-lligat-slab \
	font-taprom \
	font-herr-von-muellerhoff \
	font-delius \
	font-graduate \
	font-simonetta \
	font-oleo-script \
	font-kavoon \
	font-gfs-neohellenic \
	font-fasthand \
	font-cherry-cream-soda \
	font-unifrakturcook \
	font-raleway-dots \
	font-ahuramzda \
	font-open-sans-condensed \
	font-patrick-hand \
	font-norwester \
	font-mukti-narrow \
	font-encodesans-condensed \
	font-jolly-lodger \
	font-felipa \
	font-padauk \
	font-andada \
	font-mononoki \
	font-inria \
	font-bowlby-one \
	font-salsa \
	font-marcellus \
	font-jura \
	font-old-standard-tt \
	font-iceberg \
	font-tex-gyre-schola-math \
	font-julius-sans-one \
	font-gorditas \
	font-antic-slab \
	font-podkova \
	font-kenia \
	font-averia-libre \
	font-blokk-neue \
	font-limelight \
	font-blockzone \
	font-merriweather-sans \
	font-moul \
	font-seoulhangang \
	font-expletus-sans \
	font-gfs-didot \
	font-risque \
	font-medievalsharp \
	font-judson \
	font-atomic-age \
	font-marta \
	font-denk-one \
	font-bubblegum-sans \
	font-wonder-unit-sans \
	font-linux-biolinum \
	font-ovo \
	font-lobster \
	font-luculent \
	font-metal-mania \
	font-hanalei \
	font-gilbert \
	font-space-grotesk \
	font-mclaren \
	font-gravitas-one \
	font-pt-sans \
	font-disclaimer \
	font-princess-sofia \
	font-tex-gyre-bonum-math \
	font-chelsea-market \
	font-migu-1c \
	font-delius-unicase \
	font-rotinonhsonni-serif \
	font-cantata-one \
	font-almendra-sc \
	font-ezra-sil \
	font-yesteryear \
	font-marcellus-sc \
	font-holtwood-one-sc