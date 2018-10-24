module MusicStore
  module Entities
    class Song < Grape::Entity
      expose :name
      expose :singer
      expose :ratings, using: MusicStore::Entities::Rating
    end
  end
end
