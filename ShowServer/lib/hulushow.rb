class HuluShow
  def initialize(jsondata)
    # shows data
    id = -1
    name = ""
    description = ""
    genre = ""
    rating = ""
    videoCount = -1
    originalPremiereDate = ""

    # availability data
    huluPlusLivingRoom = false
    huluPlusMobile = false
    fullEpisodesCount = -1
    maxSeasonNumber = -1
    minSeasonNumber = -1

    # company data
    canonicalCompanyName = ""
    companyName = ""
    companyId = -1

    # channel data
    primaryChannel = ""
  end
end