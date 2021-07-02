﻿using CampaignMicroservice.Core.Interface;
using CampaignMicroservice.Core.Model;
using CampaignService.DataAccess.Adaptee;
using CampaignService.DataAccess.Adapter;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Linq;

namespace CampaignService.DataAccess.Implementation
{
    public class CampaignRequestRepository : Repository, ICampaignRequestRepository
    {
        public CampaignRequestAdapter _campaignRequestTarget = new CampaignRequestAdapter(new CampaignRequestAdaptee());
        public IUserRepository _userRepository;

        public CampaignRequestRepository(IConfiguration configuration, IUserRepository userRepository) :
            base(configuration)
        {
            _userRepository = userRepository;
        }

        public IEnumerable<CampaignRequest> GetBy(Guid userId, string isApproved)
        {
            StringBuilder queryBuilder = new StringBuilder("SELECT cr.id, cr.is_approved, r.id, r.username, " +
                "r.first_name, r.last_name, r.date_of_birth, r.gender, r.profile_image_path, r.is_private, " +
                "r.is_banned, r.category, cr.action, c.id, t.min_date_of_birth, t.max_date_of_birth, " +
                "t.gender, a.id, a.username, a.first_name, a.last_name, a.date_of_birth, a.gender, " +
                "a.profile_image_path, a.is_private, a.is_banned, a.website_address, c.likes_count, " +
                "c.dislikes_count, c.exposure_count, c.click_count, c.type, c.start_date, c.end_date, " +
                "c.date_of_change ");
            queryBuilder.Append("FROM dbo.CampaignRequest as cr, dbo.Campaign as c, dbo.RegisteredUser as r," +
                " dbo.RegisteredUser as a, dbo.TargetAudience as t ");
            queryBuilder.Append("WHERE cr.campaign_id = c.id AND cr.verified_user_id = r.id AND " +
                "c.target_audience_id = t.id AND c.agent_id = a.id " +
                "AND a.action=\'created\' AND r.id = @Id ");

            List<SqlParameter> parameters = new List<SqlParameter>()
            {
                new SqlParameter("@Id", SqlDbType.UniqueIdentifier) { Value = userId },
            };

            if (!String.IsNullOrWhiteSpace(isApproved))
            {
                queryBuilder.Append("AND a.is_approved = @IsApproved");
                SqlParameter parameterIsApproved = new SqlParameter("@IsApproved", SqlDbType.Bit)
                { Value = isApproved.Equals("true") ? 1 : 0 };
                parameters.Add(parameterIsApproved);
            }

            string query = queryBuilder.ToString();

            DataTable dataTable = ExecuteQuery(query, parameters);
            return (from DataRow dataRow in dataTable.Rows
                    select (CampaignRequest)_campaignRequestTarget.ConvertSql(dataRow,
                    _userRepository.GetBlockedBy(Guid.Parse(dataRow[17].ToString())),
                        _userRepository.GetBlocking(Guid.Parse(dataRow[17].ToString())),
                        _userRepository.GetFollowing(Guid.Parse(dataRow[17].ToString())),
                        _userRepository.GetFollowers(Guid.Parse(dataRow[17].ToString())),
                        _userRepository.GetMutedBy(Guid.Parse(dataRow[17].ToString())),
                        _userRepository.GetMuted(Guid.Parse(dataRow[17].ToString())), new List<Ad>(),
                        new List<ExposureDate>(),
                        _userRepository.GetBlockedBy(userId),
                        _userRepository.GetBlocking(userId),
                        _userRepository.GetFollowing(userId),
                        _userRepository.GetFollowers(userId),
                        _userRepository.GetMutedBy(userId),
                        _userRepository.GetMuted(userId))).ToList();
        }

        public CampaignRequest Save(CampaignRequest campaignRequest)
        {
            StringBuilder queryBuilder = new StringBuilder("INSERT INTO dbo.CampaignRequest ");
            queryBuilder.Append("(id, is_approved, campaign_id, verified_user_id, action) ");
            queryBuilder.Append("VALUES (@id, @is_approved, @campaign_id, @verified_user_id, @action);");

            string query = queryBuilder.ToString();

            List<SqlParameter> parameters = new List<SqlParameter>()
            {
                new SqlParameter("@id", SqlDbType.UniqueIdentifier) { Value = campaignRequest.Id },
                new SqlParameter("@is_approved", SqlDbType.Bit) { Value = campaignRequest.IsApproved },
                new SqlParameter("@campaign_id", SqlDbType.UniqueIdentifier) { Value = campaignRequest.Campaign.Id },
                new SqlParameter("@verified_user_id", SqlDbType.UniqueIdentifier) { Value = campaignRequest.VerifiedUser.Id },
                new SqlParameter("@action", SqlDbType.NVarChar) { Value = campaignRequest.CampaignRequestAction.ToString() },
            };

            ExecuteQuery(query, parameters);

            return campaignRequest;
        }

        public CampaignRequest Update(CampaignRequest campaignRequest)
        {
            StringBuilder queryBuilder = new StringBuilder("UPDATE dbo.CampaignRequest ");
            queryBuilder.Append("SET is_approved = @is_approved, campaign_id = @campaign_id, " +
                "verified_user_id = @verified_user_id, action = @action ");
            queryBuilder.Append("WHERE id = @id;");

            string query = queryBuilder.ToString();

            List<SqlParameter> parameters = new List<SqlParameter>
            {
                new SqlParameter("@id", SqlDbType.UniqueIdentifier) { Value = campaignRequest.Id },
                new SqlParameter("@is_approved", SqlDbType.Bit) { Value = campaignRequest.IsApproved },
                new SqlParameter("@campaign_id", SqlDbType.UniqueIdentifier) { Value = campaignRequest.Campaign.Id },
                new SqlParameter("@action", SqlDbType.NVarChar) { Value = campaignRequest.CampaignRequestAction.ToString() },
                new SqlParameter("@verified_user_id", SqlDbType.UniqueIdentifier) { Value = campaignRequest.VerifiedUser.ToString() },
            };

            ExecuteQuery(query, parameters);

            return campaignRequest;
        }
    }
}