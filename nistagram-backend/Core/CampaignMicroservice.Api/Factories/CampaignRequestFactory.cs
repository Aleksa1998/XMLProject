﻿using CampaignMicroservice.Api.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;

namespace CampaignMicroservice.Api.Factories
{
    public class CampaignRequestFactory
    {
        private readonly VerifiedUserFactory verifiedUserFactory;

        public CampaignRequestFactory(VerifiedUserFactory verifiedUserFactory)
        {
            this.verifiedUserFactory = verifiedUserFactory;
        }

        public CampaignRequest Create(Core.Model.CampaignRequest campaignRequest)
        {
            return new CampaignRequest
            {
                Id = campaignRequest.Id,
                IsApproved = campaignRequest.IsApproved,
                VerifiedUser = verifiedUserFactory.Create(campaignRequest.VerifiedUser),
                Campaign = ConvertCampaign(campaignRequest.Campaign),
                CampaignRequestAction = campaignRequest.CampaignRequestAction
            };
        }

        public IEnumerable<CampaignRequest> CreateCampaignRequests(IEnumerable<Core.Model.CampaignRequest> campaignRequests)
        {
            return campaignRequests.Select(campaignRequest => Create(campaignRequest)).ToList();
        }

        private Campaign ConvertCampaign(Core.Model.Campaign campaign)
        {
            if (campaign.GetType().Name.Equals("OneTimePostCampaign"))
            {
                Core.Model.OneTimePostCampaign oneTimePostCampaign = (Core.Model.OneTimePostCampaign)campaign;
                return new Campaign
                {
                    Id = campaign.Id,
                    TargetAudience = new TargetAudience
                    {
                        MinDateOfBirth = campaign.TargetAudience.MinDateOfBirth,
                        MaxDateOfBirth = campaign.TargetAudience.MaxDateOfBirth,
                        Gender = campaign.TargetAudience.Gender
                    },
                    AgentId = campaign.Agent.Id,
                    StartDate = DateTime.Now,
                    EndDate = DateTime.Now,
                    DateOfChange = DateTime.Now,
                    ExposureDates = new List<ExposureDate>() { ConvertExposureDate(oneTimePostCampaign.ExposureDate) },
                    Ads = ConvertAds(campaign.Ads)
                };
            }
            else if (campaign.GetType().Name.Equals("OneTimeStoryCampaign"))
            {
                Core.Model.OneTimeStoryCampaign oneTimeStoryCampaign = (Core.Model.OneTimeStoryCampaign)campaign;
                return new Campaign
                {
                    Id = campaign.Id,
                    TargetAudience = new TargetAudience
                    {
                        MinDateOfBirth = campaign.TargetAudience.MinDateOfBirth,
                        MaxDateOfBirth = campaign.TargetAudience.MaxDateOfBirth,
                        Gender = campaign.TargetAudience.Gender
                    },
                    AgentId = campaign.Agent.Id,
                    StartDate = DateTime.Now,
                    EndDate = DateTime.Now,
                    DateOfChange = DateTime.Now,
                    ExposureDates = new List<ExposureDate>() { ConvertExposureDate(oneTimeStoryCampaign.ExposureDate) },
                    Ads = ConvertAds(campaign.Ads)
                };
            }
            else if (campaign.GetType().Name.Equals("RecurringPostCampaign"))
            {
                Core.Model.RecurringPostCampaign reccuringPostCampaign = (Core.Model.RecurringPostCampaign)campaign;
                return new Campaign
                {
                    Id = campaign.Id,
                    TargetAudience = new TargetAudience
                    {
                        MinDateOfBirth = campaign.TargetAudience.MinDateOfBirth,
                        MaxDateOfBirth = campaign.TargetAudience.MaxDateOfBirth,
                        Gender = campaign.TargetAudience.Gender
                    },
                    AgentId = campaign.Agent.Id,
                    StartDate = DateTime.Now,
                    EndDate = DateTime.Now,
                    DateOfChange = DateTime.Now,
                    ExposureDates = ConvertExposureDates(reccuringPostCampaign.ExposureDates),
                    Ads = ConvertAds(campaign.Ads)
                };
            }
            else
            {
                Core.Model.RecurringStoryCampaign reccuringStoryCampaign = (Core.Model.RecurringStoryCampaign)campaign;
                return new Campaign
                {
                    Id = campaign.Id,
                    TargetAudience = new TargetAudience
                    {
                        MinDateOfBirth = campaign.TargetAudience.MinDateOfBirth,
                        MaxDateOfBirth = campaign.TargetAudience.MaxDateOfBirth,
                        Gender = campaign.TargetAudience.Gender
                    },
                    AgentId = campaign.Agent.Id,
                    StartDate = DateTime.Now,
                    EndDate = DateTime.Now,
                    DateOfChange = DateTime.Now,
                    ExposureDates = ConvertExposureDates(reccuringStoryCampaign.ExposureDates),
                    Ads = ConvertAds(campaign.Ads)
                };
            }
        }

        private Ad ConvertAd(Core.Model.Ad ad)
        {
            return new Ad
            {
                Id = ad.Id,
                ContentId = ad.Content.Id,
                Type = ad.Content.GetType().Name,
                Link = ad.Link,
                ClickCount = int.Parse(ad.ClickCount),
                ProfileOwnerId = ad.ProfileOwner.Id
            };
        }

        private IEnumerable<Ad> ConvertAds(IEnumerable<Core.Model.Ad> ads)
        {
            return ads.Select(ad => ConvertAd(ad)).ToList();
        }

        private ExposureDate ConvertExposureDate(Core.Model.ExposureDate exposureDate)
        {
            return new ExposureDate
            {
                Id = exposureDate.Id,
                Time = exposureDate.Time,
                SeenByIds = ConvertSeenByIds(exposureDate.SeenBy)
            };
        }

        private IEnumerable<ExposureDate> ConvertExposureDates(IEnumerable<Core.Model.ExposureDate> exposureDates)
        {
            return exposureDates.Select(exposureDate => ConvertExposureDate(exposureDate)).ToList();
        }

        private IEnumerable<Guid> ConvertSeenByIds(IEnumerable<Core.Model.RegisteredUser> seenBy)
        {
            return (from Core.Model.RegisteredUser user in seenBy
                    select user.Id).ToList();
        }
    }
}