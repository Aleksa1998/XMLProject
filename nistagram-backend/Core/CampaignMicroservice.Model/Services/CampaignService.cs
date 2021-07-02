﻿using CampaignMicroservice.Core.Interface;
using CampaignMicroservice.Core.Model;
using CSharpFunctionalExtensions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CampaignMicroservice.Core.Services
{
    public class CampaignService
    {
        private readonly ICampaignRepository _campaignRepository;
        private readonly IExposureDateRepository _exposureDateRepository;
        private readonly ExposureDateService _exposureDateService;

        public CampaignService(ICampaignRepository campaignRepository, IExposureDateRepository exposureDateRepository,
            ExposureDateService exposureDateService)
        {
            _exposureDateRepository = exposureDateRepository;
            _exposureDateService = exposureDateService;
            _campaignRepository = campaignRepository;
        }

        private Result Save(Campaign campaign)
        {
            if (_campaignRepository.GetById(campaign.Id).HasValue) return Result.Failure("Campaign with that id already exist");
            if (campaign.GetType().Name.Equals("OneTimePostCampaign"))
            {
                OneTimePostCampaign oneTimePostCampaign = (OneTimePostCampaign)campaign;
                if (_exposureDateService.Save(oneTimePostCampaign.ExposureDate).IsFailure) return Result.Failure("Exposure date with that id already exist");
            }
            if (campaign.GetType().Name.Equals("OneTimeStoryCampaign"))
            {
                OneTimeStoryCampaign oneTimeStoryCampaign = (OneTimeStoryCampaign)campaign;
                if (_exposureDateService.Save(oneTimeStoryCampaign.ExposureDate).IsFailure) return Result.Failure("Exposure date with that id already exist");
            }
            if (campaign.GetType().Name.Equals("RecurringPostCampaign"))
            {
                RecurringPostCampaign recurringPostCampaign = (RecurringPostCampaign)campaign;
                foreach (ExposureDate exposureDate in recurringPostCampaign.ExposureDates)
                {
                    if (_exposureDateService.Save(exposureDate).IsFailure) return Result.Failure("Exposure date with that id already exist");
                }
            }
            else
            {
                RecurringStoryCampaign recurringStoryCampaign = (RecurringStoryCampaign)campaign;
                foreach (ExposureDate exposureDate in recurringStoryCampaign.ExposureDates)
                {
                    if (_exposureDateService.Save(exposureDate).IsFailure) return Result.Failure("Exposure date with that id already exist");
                }
            }
            _campaignRepository.Save(campaign);
            return Result.Success();
        }
    }
}