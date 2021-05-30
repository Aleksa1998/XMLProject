﻿using PostMicroservice.Core.Model;
using System;
using System.Collections.Generic;
using System.Data;

namespace PostMicroservice.DataAccess.Adaptee
{
    public class PostAdaptee
    {
        public Post ConvertSqlDataReaderToPostWithAttributes(DataRow dataRow, IEnumerable<RegisteredUser> likes,
            IEnumerable<RegisteredUser> dislikes, IEnumerable<HashTag> hashTags,
            IEnumerable<Comment> comments, IEnumerable<RegisteredUser> taggedUsers)
        {
            if (dataRow[3].ToString().Trim().Equals("album", StringComparison.InvariantCultureIgnoreCase))
            {
                return ConvertSqlDataReaderToPostAlbumWithAttributes(dataRow, likes, dislikes,
                hashTags, comments, taggedUsers);
            }
            else
            {
                return ConvertSqlDataReaderToPostSingleWithAttributes(dataRow, likes, dislikes,
                hashTags, comments, taggedUsers);
            }
        }

        private PostAlbum ConvertSqlDataReaderToPostAlbumWithAttributes(DataRow dataRow,
            IEnumerable<RegisteredUser> likes, IEnumerable<RegisteredUser> dislikes,
            IEnumerable<HashTag> hashTags, IEnumerable<Comment> comments,
            IEnumerable<RegisteredUser> taggedUsers)
        {
            return PostAlbum.Create(
                id: Guid.Parse(dataRow[0].ToString().Trim()),
                timeStamp: DateTime.Parse(dataRow[1].ToString().Trim()),
                description: Description.Create(dataRow[2].ToString().Trim()).Value,
                registeredUser: RegisteredUser.Create(
                                        id: Guid.Parse(dataRow[8].ToString().Trim()),
                                        username: Username.Create(dataRow[9].ToString().Trim()).Value,
                                        firstName: FirstName.Create(dataRow[10].ToString().Trim()).Value,
                                        lastName: LastName.Create(dataRow[11].ToString().Trim()).Value,
                                        profileImagePath: ProfileImagePath.Create(dataRow[12].ToString().Trim()).Value,
                                        isPrivate: bool.Parse(dataRow[13].ToString().Trim()),
                                        isAcceptingTags: bool.Parse(dataRow[14].ToString().Trim()),
                                        blockedUsers: new List<RegisteredUser>(),
                                        blockedByUsers: new List<RegisteredUser>(),
                                        following: new List<RegisteredUser>(),
                                        followers: new List<RegisteredUser>()).Value,
                likes: likes,
                dislikes: dislikes,
                comments: comments,
                location: Location.Create(id: Guid.Parse(dataRow[4].ToString().Trim()),
                                          street: Street.Create(dataRow[5].ToString().Trim()).Value,
                                          cityName: CityName.Create(dataRow[6].ToString().Trim()).Value,
                                          country: Country.Create(dataRow[7].ToString().Trim()).Value).Value,
                taggedUsers: taggedUsers,
                hashTags: hashTags,
                contentPaths: new List<ContentPath>()).Value;
        }

        private PostSingle ConvertSqlDataReaderToPostSingleWithAttributes(DataRow dataRow,
            IEnumerable<RegisteredUser> likes, IEnumerable<RegisteredUser> dislikes,
            IEnumerable<HashTag> hashTags, IEnumerable<Comment> comments,
            IEnumerable<RegisteredUser> taggedUsers)
        {
            return PostSingle.Create(
                id: Guid.Parse(dataRow[0].ToString().Trim()),
                timeStamp: DateTime.Parse(dataRow[1].ToString().Trim()),
                description: Description.Create(dataRow[2].ToString().Trim()).Value,
                registeredUser: RegisteredUser.Create(
                                        id: Guid.Parse(dataRow[8].ToString().Trim()),
                                        username: Username.Create(dataRow[9].ToString().Trim()).Value,
                                        firstName: FirstName.Create(dataRow[10].ToString().Trim()).Value,
                                        lastName: LastName.Create(dataRow[11].ToString().Trim()).Value,
                                        profileImagePath: ProfileImagePath.Create(dataRow[12].ToString().Trim()).Value,
                                        isPrivate: bool.Parse(dataRow[13].ToString().Trim()),
                                        isAcceptingTags: bool.Parse(dataRow[14].ToString().Trim()),
                                        blockedUsers: new List<RegisteredUser>(),
                                        blockedByUsers: new List<RegisteredUser>(),
                                        following: new List<RegisteredUser>(),
                                        followers: new List<RegisteredUser>()).Value,
                likes: likes,
                dislikes: dislikes,
                comments: comments,
                location: Location.Create(id: Guid.Parse(dataRow[4].ToString().Trim()),
                                          street: Street.Create(dataRow[5].ToString().Trim()).Value,
                                          cityName: CityName.Create(dataRow[6].ToString().Trim()).Value,
                                          country: Country.Create(dataRow[7].ToString().Trim()).Value).Value,
                taggedUsers: taggedUsers,
                hashTags: hashTags,
                contentPath: ContentPath.Create(dataRow[15].ToString().Trim()).Value).Value;
        }
    }
}