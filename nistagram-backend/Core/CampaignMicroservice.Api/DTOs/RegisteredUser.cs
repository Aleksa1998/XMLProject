﻿using System;
using System.Collections.Generic;

namespace CampaignMicroservice.Api.DTOs
{
    public class RegisteredUser
    {
        public Guid Id { get; set; }
        public string Username { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string Gender { get; set; }
        public string ProfileImagePath { get; set; }
        public bool IsPrivate { get; set; }
        public IEnumerable<RegisteredUser> BlockedByUsers { get; set; }
        public IEnumerable<RegisteredUser> BlockedUsers { get; set; }
        public IEnumerable<RegisteredUser> Following { get; set; }
        public IEnumerable<RegisteredUser> Followers { get; set; }
        public IEnumerable<RegisteredUser> MutedByUsers { get; set; }
        public IEnumerable<RegisteredUser> MutedUsers { get; set; }
        public bool IsBanned { get; set; }
    }
}