package org.yearup.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.yearup.data.ProfileDao;
import org.yearup.data.UserDao;
import org.yearup.models.Product;
import org.yearup.models.Profile;
import org.yearup.models.User;

import java.math.BigDecimal;
import java.security.Principal;
import java.util.List;
@PreAuthorize("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')")
@RestController
@RequestMapping("profile")
@CrossOrigin
public class ProfileController {
    private ProfileDao profileDao;
    private UserDao userDao;

    @Autowired
    public ProfileController(ProfileDao profileDao, UserDao userDao) {
        this.profileDao = profileDao;
        this.userDao = userDao;
    }


    @GetMapping("")

    public Profile getById(Principal principal) {
        try { // get the currently logged in username
            String userName = principal.getName();
            // find database user by userId
            User user = userDao.getByUserName(userName);
            int userId = user.getId();
            var profile = profileDao.getProfileById(userId);

            if (profile == null)
                throw new ResponseStatusException(HttpStatus.NOT_FOUND);

            return profile;
        } catch (Exception ex) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Oops... our bad.");
        }
    }


    @PutMapping("")
    public Profile updateProfile(@RequestBody Profile profile, Principal principal) {

        try {
            String userName = principal.getName();
            User user = userDao.getByUserName(userName);
            int userId = user.getId();
            profileDao.update(userId, profile);
            return profileDao.getProfileById(userId);
        } catch (Exception ex) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Oops... our bad.");

        }
    }



}

