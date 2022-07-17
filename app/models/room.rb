class Room < ApplicationRecord
  #room内では多くのuser_roomがあるので、１対多。
  #room内では多くのchatがあるので、１対多。
  has_many :user_rooms
  has_many :chats
end
