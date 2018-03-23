//
//  LyricsNetEase.swift
//
//  This file is part of LyricsX
//  Copyright (C) 2017  Xander Deng
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

import Foundation

private let netEaseSearchBaseURLString = "http://music.163.com/api/search/pc?"
private let netEaseLyricsBaseURLString = "http://music.163.com/api/song/lyric?"

public final class LyricsNetEase: _LyricsProvider {
    
    public static let source: LyricsProviderSource = .netease
    
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func searchTask(request: LyricsSearchRequest, completionHandler: @escaping ([NetEaseResponseSearchResult.Result.Song]) -> Void) -> URLSessionTask? {
        let parameter: [String: Any] = [
            "s": request.searchTerm.description,
            "offset": 0,
            "limit": 10,
            "type": 1,
            ]
        let url = URL(string: netEaseSearchBaseURLString + parameter.stringFromHttpParameters)!
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("http://music.163.com/", forHTTPHeaderField: "Referer")
        return session.dataTask(with: req, type: NetEaseResponseSearchResult.self) { model, error in
            completionHandler(model?.songs ?? [])
        }
    }
    
    func fetchTask(token: NetEaseResponseSearchResult.Result.Song, completionHandler: @escaping (Lyrics?) -> Void) -> URLSessionTask? {
        let parameter: [String: Any] = [
            "id": token.id,
            "lv": 1,
            "kv": 1,
            "tv": -1,
            ]
        let url = URL(string: netEaseLyricsBaseURLString + parameter.stringFromHttpParameters)!
        return session.dataTask(with: url, type: NetEaseResponseSingleLyrics.self) { model, error in
            guard let model = model,
                let lrc = (model.lrc?.lyric).flatMap(Lyrics.init) else {
                    completionHandler(nil)
                    return
            }
            
            if let transLrcContent = model.tlyric?.lyric,
                let transLrc = Lyrics(transLrcContent) {
                lrc.merge(translation: transLrc)
            }
            
            // FIXME: merge inline time tags back to lyrics
            // if let taggedLrc = (model.klyric?.lyric).flatMap(Lyrics.init(netEaseKLyricContent:))
            
            lrc.idTags[.title]   = token.name
            lrc.idTags[.artist]  = token.artists.first?.name
            lrc.idTags[.album]   = token.album.name
            lrc.idTags[.lrcBy]   = model.lyricUser?.nickname
            
            lrc.length = Double(token.duration) / 1000
            lrc.metadata.source      = .netease
            lrc.metadata.artworkURL  = token.album.picUrl
            lrc.metadata.providerToken = "\(token.id)"
            
            completionHandler(lrc)
        }
    }
}
