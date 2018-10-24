module MusicStore
  module Entities
    class Index < Grape::Entity
      expose :name
      expose :singer
      expose :rating
    end
  end
end
