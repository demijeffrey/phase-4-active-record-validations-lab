class Post < ApplicationRecord

    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { in: ['Fiction', 'Non-Fiction']}

    # validate :make_title_clickbaity

    # def make_title_clickbaity
    #     unless title.include?('Wont', 'Believe',  'Secret',  'Top [number]',  'Guess')
    #         errors.add(:title, "needs to have key word")
    #     end
    # end

    validate :clickbait?

    CLICKBAIT_PATTERNS = [
        /Won't Believe/i,
        /Secret/i,
        /Top \d/i,
        /Guess/i
      ]

      def clickbait?
        if CLICKBAIT_PATTERNS.none? { |pat| pat.match title }
          errors.add(:title, "must be clickbait")
        end
      end

end
