﻿using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using StoryMicroservice.Core.Interface.Repository;
using StoryMicroservice.DataAccess.Factories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace StoryMicroservice.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LocationsController : Controller
    {
        private readonly ILocationRepository _locationRepository;
        private readonly LocationFactory locationFactory;

        public LocationsController(ILocationRepository locationRepository, LocationFactory locationFactory)
        {
            _locationRepository = locationRepository;
            this.locationFactory = locationFactory;
        }

        [Authorize(Roles = "RegisteredUser")]
        public IActionResult GetAll()
        {
            return Ok(locationFactory.CreateLocations(_locationRepository.GetAll()));
        }
    }
}