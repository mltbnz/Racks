//
//  Constants.h
//  Racks
//
//  Created by Mercedes Bünz on 05.11.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#ifndef Racks_Constants_h
#define Racks_Constants_h

// MUSICBRAINZ
#define MUSICBRAINZURL @"http://musicbrainz.org/ws/2/release?query=barcode:"
#define MUSICBRAINZFORMAT @"&fmt=json"
// DISCOGS
#define DISCOGSURL @"http://api.discogs.com/database/search?&q="
#define DISCOGSRELEASE_TITLE @"&release_title="
#define DISCOGSRETURNTYPE @"&format=json"
// ROVI
#define ROVIURL @"http://api.rovicorp.com/search/v2.1/music/autocomplete?"
#define AUTOCOMPLETEKEY @"cfxhrmdbmhtn275wn9r5j49h"
#define AUTOCOMPLETESECRET @"5vbmNmWVj6"
#define SEARCHKEY @"r9grg9arayybsj863kpx6qy6"
#define SEARCHSECRET @"eSdE5eZyBc"
//LASFM
#define LASTFMSEARCHARTISTURL @"http://ws.audioscrobbler.com/2.0/?method=artist.search&artist="
#define LASTFMKEY @"&api_key=70d53fc392eddafb7d6b0d2f1c5a2e0a"
#define LASTFMSEARCHALBUMURL @"http://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&artist="
#define LASTFMKEY @"&api_key=70d53fc392eddafb7d6b0d2f1c5a2e0a"
#define RETURNTYPE @"&format=json"
//
#define LASTFMALBUMINFOURL @"http://ws.audioscrobbler.com/2.0/?method=album.getinfo"
#define LASTFMKEY @"&api_key=70d53fc392eddafb7d6b0d2f1c5a2e0a"
#define RETURNTYPE @"&format=json"
#define ARTIST @"&artist="
#define ALBUM @"&album="

#define LASTFMSEARCHINFOURL @"http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist="

#endif
