module MusicStore
  class Base < Grape::API
    mount MusicStore::V1::Songs # music_store/v1/songs
  end
end
