require 'spec_helper'

describe ShowsController do
  describe "GET shows#index" do
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
      get '/shows'

      expect(response).to be_success

      shows_json = json['shows']
      expect(shows_json.size).to eq(4)

      first_show = shows_json.first
      expect(first_show['id']).to eq(@american_horror_story.id)
      expect(first_show['name']).to eq('American Horror Story')
      expect(first_show['episodes_count']).to eq(2)

      second_show = shows_json.second
      expect(second_show['id']).to eq(@dexter.id)
      expect(second_show['name']).to eq('Dexter')
      expect(second_show['episodes_count']).to eq(3)

      third_show = shows_json.third
      expect(third_show['id']).to eq(@fargo.id)
      expect(third_show['name']).to eq('Fargo')
      expect(third_show['episodes_count']).to eq(1)

      fourth_show = shows_json.fourth
      expect(fourth_show['id']).to eq(@hannibal.id)
      expect(fourth_show['name']).to eq('Hannibal')
      expect(fourth_show['episodes_count']).to eq(4)
    end
  end
end
