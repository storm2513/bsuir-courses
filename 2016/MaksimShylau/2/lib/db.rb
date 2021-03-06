class Database
	def initialize(id)
		user = User.new(id)
		@redis = Redis.new(url: ENV["redis://h:phl40bf5cs3286b1h8pflrroll@ec2-46-51-184-223.eu-west-1.compute.amazonaws.com:8139"])
    if !@redis.get(user.id).nil?
      hash = JSON.parse(@redis.get(user.id)).to_hash
    else hash = {}
    end
    subject = hash["subject"]
    if subject.nil?
      subject = []
      hash["subject"]=[{}]
    end
    subject_count = hash["subject_count"]
    if subject_count.nil? then subject_count = 0; hash["subject_count"]= 0 end
    @redis.set(user.id, hash.to_json)
    return @redis
	end

	def get_hash(id)
		hash = JSON.parse(@redis.get(id)).to_hash
		return hash
	end

	def set_hash(hash, id)
		@redis.set(id, hash.to_json)
	end

	attr_accessor :redis
end