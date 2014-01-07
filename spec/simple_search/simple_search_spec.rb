require 'spec_helper'

describe SimpleSearch do

  after :each do
    User.delete_all
  end

  describe '#result' do
    it 'returns all records when no search parameters given' do
      params = {"controller"=>"user", "action"=>"index", "filters"=>{}}
      user1 = User.create
      user2 = User.create

      search = SimpleSearch::Search.new(params)
      expect(search.result).to eq [user1, user2]
    end

    it 'returns filtered records for given search parameters' do
      params = { "controller"=>"user",
                 "action"=>"index",
                 "filters"=>{ 'first_name_eq' => 'Peter',
                              'last_name_eq' => 'Hornicek' }}

      fred = User.create(first_name: 'Fred', last_name: 'Novak')
      peter = User.create(first_name: 'Peter', last_name: 'Novotny')
      peter_hornicek = User.create(first_name: 'Peter', last_name: 'Hornicek')

      search = SimpleSearch::Search.new(params)
      expect(search.result).to eq [peter_hornicek]
      expect(search.result).not_to include fred
      expect(search.result).not_to include peter
    end

    it 'returns filtered records using custom model filter methods' do
      params = { "controller"=>"user",
                 "action"=>"index",
                 "filters"=> { 'name_search' => 'Fred' }}

      fred_novak = User.create(first_name: 'Fred', last_name: 'Novak')
      peter_fred = User.create(first_name: 'Peter', last_name: 'Fred')
      alex_novotny = User.create(first_name: 'Alex', last_name: 'Novotny')

      search = SimpleSearch::Search.new(params)
      expect(search.result).to include fred_novak
      expect(search.result).to include peter_fred
      expect(search.result).not_to include alex_novotny
    end

    it 'ignores params which would search over attributes which are not on model whitelist' do
      params = { "controller"=>"user",
                 "action"=>"index",
                 "filters"=> { 'mood_eq' => 'happy' }}

      fred = User.create(first_name: 'Fred', mood: 'happy')
      peter = User.create(first_name: 'Peter', mood: 'sad')

      search = SimpleSearch::Search.new(params)
      expect(search.result).to eq [fred, peter]
    end
  end

  describe 'searched values are accessible by on search object through method missing' do
    it 'search with first_name_eq is accessible' do
      params = { "controller"=>"user",
                 "action"=>"index",
                 "filters"=> { 'first_name_eq' => 'Fred',
                               'last_name_eq' => 'Novak' }}

      search = SimpleSearch::Search.new(params)
      expect(search.first_name_eq).to eq 'Fred'
    end
  end

  describe '#model' do
    it 'returns searched model' do
      params = {"controller"=>"user", "action"=>"index", "filters"=>{}}
      search = SimpleSearch::Search.new(params)
      expect(search.model).to eq User
    end
  end
end
