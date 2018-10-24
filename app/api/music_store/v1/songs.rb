module MusicStore
  module V1
    class Songs < Grape::API
      version "v1", using: :path  # Chỉ định phiên bản của API
      format :json                # dữ liệu trả về là Json
      prefix :api                 # link dẫn trên trình duyệt luôn bắt đầu với /api

      resource :songs do
        desc "Return list of songs"
        get do
          song = Song.all
          present song
        end

        desc "Create a new song"
        params do
          requires :name, type: String
          requires :singer, type: String
          requires :rating, type: Float
        end
        post do
          Song.create!({name:params[:name], singer:params[:singer], rating:params[:rating]})
        end

        desc "Return a specific song"
        route_param :id do
          get do
            song = Song.find(params[:id])
            present song, with: MusicStore::Entities::Song
          end
        end

        desc "Update a specific song"
        route_param :id do
          put do
            Song.find(params[:id]).update({rating:params[:rating] })
          end
        end

        desc "Delete a specific song"
        route_param :id do
          delete do
            song = Song.find(params[:id])
            Song.destroy
          end
        end

        route_param :id do
          resource :ratings do
            desc "Create a rating"
            params do
              requires :ratings, type: Hash do
                requires :rating, type: Float, desc: "Rating of 1 user"
              end
            end
            post do
              @song = Song.find(params[:id])
              @rating = @song.ratings.create!(params[:rating])  # @rating = Rating.new(params[:rating]) hoặc @rating = @song.ratings.build
              @song.update!(rating: @rating.rating)             # @rating.save
            end
          end
        end
      end
    end
  end
end
