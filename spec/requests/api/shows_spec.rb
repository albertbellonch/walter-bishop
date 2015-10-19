require 'spec_helper'

describe Api::ShowsController do
  describe "GET api/shows#index" do
    before do
      @dexter, @hannibal, @american_horror_story,
        @fargo = {
        'Dexter' => 3,
        'Hannibal' => 4,
        'American Horror Story' => 2,
        'Fargo' => 1
      }.map do |show_name, episodes_count|
        show = create :show, name: show_name
        episodes_count.times do |i|
          create :episode, number: i, show: show
        end
        show
      end
    end

    it "should return the shows information in alphabetical order" do
      get '/api/shows'

      expect(response).to be_success

      shows_json = json['data']
      expect(shows_json.size).to eq(4)

      first_show = shows_json.first
      expect(first_show['id']).to eq(@american_horror_story.id.to_s)
      expect(first_show['type']).to eq('shows')
      expect(first_show['attributes']['name']).to eq('American Horror Story')
      expect(first_show['attributes']['episodes_count']).to eq(2)

      second_show = shows_json.second
      expect(second_show['id']).to eq(@dexter.id.to_s)
      expect(second_show['type']).to eq('shows')
      expect(second_show['attributes']['name']).to eq('Dexter')
      expect(second_show['attributes']['episodes_count']).to eq(3)

      third_show = shows_json.third
      expect(third_show['id']).to eq(@fargo.id.to_s)
      expect(third_show['type']).to eq('shows')
      expect(third_show['attributes']['name']).to eq('Fargo')
      expect(third_show['attributes']['episodes_count']).to eq(1)

      fourth_show = shows_json.fourth
      expect(fourth_show['id']).to eq(@hannibal.id.to_s)
      expect(fourth_show['type']).to eq('shows')
      expect(fourth_show['attributes']['name']).to eq('Hannibal')
      expect(fourth_show['attributes']['episodes_count']).to eq(4)
    end
  end
end
