require 'spec_helper'

describe EpisodesController do
  describe "GET episodes#index" do
    before do
      @dexter_show = create :show, name: 'Dexter'
      @hannibal_show = create :show, name: 'Hannibal'

      @hannibal_3_13 = create :episode, show: @hannibal_show, season: 3, number: 13,
        title: 'Hannibal Finale', description: 'H313',
        starts_at: 2.months.ago, ends_at: 1.month.ago
      @dexter_1_1 = create :episode, show: @dexter_show, season: 1, number: 1,
        title: 'The first episode ever', description: 'D11',
        starts_at: 4.years.ago, ends_at: 3.years.ago
      @dexter_1_2 = create :episode, show: @dexter_show, season: 1, number: 2,
        title: 'The second one', description: 'D12',
        starts_at: 3.years.ago, ends_at: 2.years.ago
    end

    it "should return the episodes information in airing order" do
      get '/episodes'

      expect(response).to be_success

      episodes_json = json['episodes']
      expect(episodes_json.size).to eq(3)

      first_episode = episodes_json.first
      expect(first_episode['id']).to eq(@dexter_1_1.id)
      expect(first_episode['show_id']).to eq(@dexter_show.id)
      expect(first_episode['season']).to eq(1)
      expect(first_episode['number']).to eq(1)
      expect(first_episode['title']).to eq('The first episode ever')
      expect(first_episode['description']).to eq('D11')
      expect(Time.parse(first_episode['starts_at'])).
        to be_within(1.second).of(4.years.ago)
      expect(Time.parse(first_episode['ends_at'])).
        to be_within(1.second).of(3.years.ago)

      second_episode = episodes_json.second
      expect(second_episode['id']).to eq(@dexter_1_2.id)
      expect(second_episode['show_id']).to eq(@dexter_show.id)
      expect(second_episode['season']).to eq(1)
      expect(second_episode['number']).to eq(2)
      expect(second_episode['title']).to eq('The second one')
      expect(second_episode['description']).to eq('D12')
      expect(Time.parse(second_episode['starts_at'])).
        to be_within(1.second).of(3.years.ago)
      expect(Time.parse(second_episode['ends_at'])).
        to be_within(1.second).of(2.years.ago)

      third_episode = episodes_json.third
      expect(third_episode['id']).to eq(@hannibal_3_13.id)
      expect(third_episode['show_id']).to eq(@hannibal_show.id)
      expect(third_episode['season']).to eq(3)
      expect(third_episode['number']).to eq(13)
      expect(third_episode['title']).to eq('Hannibal Finale')
      expect(third_episode['description']).to eq('H313')
      expect(Time.parse(third_episode['starts_at'])).
        to be_within(1.second).of(2.months.ago)
      expect(Time.parse(third_episode['ends_at'])).
        to be_within(1.second).of(1.month.ago)
    end
  end
end
