﻿using CSharpFunctionalExtensions;
using System;

namespace ReportMicroservice.Core.Model
{
    internal class Campaign : Content
    {
        private Campaign(Guid id, DateTime timestamp) : base(id, timestamp)
        {
        }

        public static new Result<Campaign> Create(Guid id, DateTime timestamp)
        {
            return Result.Success(new Campaign(id, timestamp));
        }
    }
}