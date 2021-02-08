class Song < ApplicationRecord
    validates :title, presence: true
    validate :no_repeat_titles
    validates :released, inclusion: { in: [true, false], message: "released cannot be blank"}
    validates :release_year, presence: true, if: :released
    validates :release_year, numericality: {less_than_or_equal_to: Date.today.year}, allow_nil:true
    validates :artist_name, presence: true

    def no_repeat_titles
        if Song.any?{|song| song!=self && song.artist_name==self.artist_name && song.release_year==self.release_year && song.title==self.title}
            errors.add(:title, "Artist already has a song with this title from this year")
        end
    end

    # def unreleased?
    #     !self.released
    # end

    # def is_released=(boo)
    #     self.released = !!boo
    # end

    # def is_released
    #     self.released
    # end
end
