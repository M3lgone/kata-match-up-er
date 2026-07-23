-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db-match-up-er
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db-match-up-er
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db-match-up-er` DEFAULT CHARACTER SET utf8 ;
USE `db-match-up-er` ;

-- -----------------------------------------------------
-- Table `db-match-up-er`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-match-up-er`.`users` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `best_time` INT NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-match-up-er`.`deck`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-match-up-er`.`deck` (
  `id` INT NOT NULL,
  `deck_name` ENUM('espanola', 'poker') NOT NULL,
  `total_cards` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-match-up-er`.`games`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-match-up-er`.`games` (
  `id` INT NOT NULL,
  `game_mode` ENUM('classic', 'fast') NOT NULL,
  `start_time` TIMESTAMP NOT NULL,
  `status_game` ENUM('playing', 'abandoned', 'finished') NOT NULL,
  `users_id` INT NOT NULL,
  `deck_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_games_users1_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_games_deck1_idx` (`deck_id` ASC) VISIBLE,
  CONSTRAINT `fk_games_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `db-match-up-er`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_games_deck1`
    FOREIGN KEY (`deck_id`)
    REFERENCES `db-match-up-er`.`deck` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-match-up-er`.`cards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-match-up-er`.`cards` (
  `id` INT NOT NULL,
  `card_suit` VARCHAR(45) NOT NULL,
  `card_value` VARCHAR(45) NOT NULL,
  `image_card_url` VARCHAR(100) NOT NULL,
  `deck_id` INT NOT NULL,
  `background_image_url` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cards_deck1_idx` (`deck_id` ASC) VISIBLE,
  CONSTRAINT `fk_cards_deck1`
    FOREIGN KEY (`deck_id`)
    REFERENCES `db-match-up-er`.`deck` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-match-up-er`.`game_score`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db-match-up-er`.`game_score` (
  `id` INT NOT NULL,
  `pairs_matched` INT NOT NULL,
  `result` ENUM('victory', 'loss') NOT NULL,
  `users_id` INT NOT NULL,
  `games_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_game_score_users1_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_game_score_games1_idx` (`games_id` ASC) VISIBLE,
  CONSTRAINT `fk_game_score_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `db-match-up-er`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_game_score_games1`
    FOREIGN KEY (`games_id`)
    REFERENCES `db-match-up-er`.`games` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
