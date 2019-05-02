class V1::PokemonSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :sprite_url, :evolution_chain_id
  attribute :poketypes, key: :types

  def sprite_url
    rails_blob_url(object.sprite, only_path: true)
  end

  def poketypes
    object.poketypes.pluck(:name)
  end

  class DetailedPokemon < V1::PokemonSerializer
    attribute :evolves_to

    def evolves_to
      object.evolutions.map { |evolution| DetailedPokemon.new(evolution).serializable_hash }
    end
  end
end