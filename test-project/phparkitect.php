<?php

declare(strict_types=1);

use Arkitect\ClassSet;
use Arkitect\CLI\Config;
use Arkitect\Expression\ForClasses\HaveNameMatching;
use Arkitect\Expression\ForClasses\NotHaveDependencyOutsideNamespace;
use Arkitect\Expression\ForClasses\ResideInOneOfTheseNamespaces;
use Arkitect\Rules\Rule;

return static function (Config $config): void {
    $classSet = ClassSet::fromDir(__DIR__ . '/src');

    $rules = [];

    // Domain layer should not depend on Infrastructure
    $rules[] = Rule::allClasses()
        ->that(new ResideInOneOfTheseNamespaces('App\Domain'))
        ->should(new NotHaveDependencyOutsideNamespace('App\Domain'))
        ->because('Domain layer should be independent');

    // Repository classes should be in Infrastructure namespace
    $rules[] = Rule::allClasses()
        ->that(new HaveNameMatching('*Repository'))
        ->should(new ResideInOneOfTheseNamespaces('App\Infrastructure'))
        ->because('Repositories should be in Infrastructure layer');

    $config
        ->add($classSet, ...$rules);
};
