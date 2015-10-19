require 'spec_helper'

describe Api::EpisodesController do
  describe "GET api/episodes#index" do
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
      get '/api/episodes'

      expect(response).to be_success

      episodes_json = json['data']
      expect(episodes_json.size).to eq(3)

      first_episode = episodes_json.first
      expect(first_episode['id']).to eq(@dexter_1_1.id.to_s)
      expect(first_episode['type']).to eq('episodes')
      expect(first_episode['relationships']['show']['data']['id']).to eq(@dexter_show.id.to_s)
      expect(first_episode['relationships']['show']['data']['type']).to eq('shows')
      expect(first_episode['attributes']['season']).to eq(1)
      expect(first_episode['attributes']['number']).to eq(1)
      expect(first_episode['attributes']['title']).to eq('The first episode ever')
      expect(first_episode['attributes']['description']).to eq('D11')
      expect(Time.parse(first_episode['attributes']['starts_at'])).
        to be_within(1.second).of(4.years.ago)
      expect(Time.parse(first_episode['attributes']['ends_at'])).
        to be_within(1.second).of(3.years.ago)

      second_episode = episodes_json.second
      expect(second_episode['id']).to eq(@dexter_1_2.id.to_s)
      expect(second_episode['type']).to eq('episodes')
      expect(second_episode['relationships']['show']['data']['id']).to eq(@dexter_show.id.to_s)
      expect(second_episode['relationships']['show']['data']['type']).to eq('shows')
      expect(second_episode['attributes']['season']).to eq(1)
      expect(second_episode['attributes']['number']).to eq(2)
      expect(second_episode['attributes']['title']).to eq('The second one')
      expect(second_episode['attributes']['description']).to eq('D12')
      expect(Time.parse(second_episode['attributes']['starts_at'])).
        to be_within(1.second).of(3.years.ago)
      expect(Time.parse(second_episode['attributes']['ends_at'])).
        to be_within(1.second).of(2.years.ago)

      third_episode = episodes_json.third
      expect(third_episode['id']).to eq(@hannibal_3_13.id.to_s)
      expect(third_episode['type']).to eq('episodes')
      expect(third_episode['relationships']['show']['data']['id']).to eq(@hannibal_show.id.to_s)
      expect(third_episode['relationships']['show']['data']['type']).to eq('shows')
      expect(third_episode['attributes']['season']).to eq(3)
      expect(third_episode['attributes']['number']).to eq(13)
      expect(third_episode['attributes']['title']).to eq('Hannibal Finale')
      expect(third_episode['attributes']['description']).to eq('H313')
      expect(Time.parse(third_episode['attributes']['starts_at'])).
        to be_within(1.second).of(2.months.ago)
      expect(Time.parse(third_episode['attributes']['ends_at'])).
        to be_within(1.second).of(1.month.ago)
    end
  end
end
