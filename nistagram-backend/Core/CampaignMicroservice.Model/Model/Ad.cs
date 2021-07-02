﻿using CSharpFunctionalExtensions;
using System;

namespace CampaignMicroservice.Core.Model
{
    public class Ad
    {
        private readonly Guid id;
        private readonly Content content;
        private readonly Link link;
        private readonly ClickCount clickCount;
        private readonly RegisteredUser profileOwner;

        private Ad(Guid id, Content content, Link link, ClickCount clickCount, RegisteredUser profileOwner)
        {
            this.id = id;
            this.content = content;
            this.link = link;
            this.clickCount = clickCount;
            this.profileOwner = profileOwner;
        }

        public static Result<Ad> Create(Guid id, Content content, Link link, ClickCount clickCount, RegisteredUser profileOwner)
        {
            return Result.Success(new Ad(id, content, link, clickCount, profileOwner));
        }
    }
}