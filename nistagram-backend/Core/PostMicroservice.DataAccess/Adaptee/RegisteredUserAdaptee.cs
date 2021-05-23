﻿using PostMicroservice.Core.Model;
using System;
using System.Data;

namespace PostMicroservice.DataAccess.Adaptee
{
    public class RegisteredUserAdaptee
    {
        public RegisteredUser ConvertSqlDataReaderToRegisteredUser(DataRow dataRow)
        {
            return RegisteredUser.Create(
                    id: Guid.Parse(dataRow[0].ToString().Trim()),
                    username: Username.Create(dataRow[1].ToString().Trim()).Value,
                    firstName: FirstName.Create(dataRow[2].ToString().Trim()).Value,
                    lastName: LastName.Create(dataRow[3].ToString().Trim()).Value,
                    isPrivate: bool.Parse(dataRow[4].ToString().Trim()),
                    isAcceptingTags: bool.Parse(dataRow[5].ToString().Trim())).Value;
        }
    }
}