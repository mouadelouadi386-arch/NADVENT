<?php
declare(strict_types=1);


final class Env
{
    private static array $valeurs = [];

    public static function charger(string $fichier): void
    {
        if (!is_file($fichier)) {
            return;
        }
        foreach (file($fichier, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $ligne) {
            $ligne = trim($ligne);
            if ($ligne === '' || $ligne[0] === '#' || !str_contains($ligne, '=')) {
                continue;
            }
            [$cle, $valeur] = explode('=', $ligne, 2);
            self::$valeurs[trim($cle)] = trim($valeur, " \t\"'");
        }
    }

    public static function get(string $cle, ?string $defaut = null): ?string
    {
        return self::$valeurs[$cle] ?? $defaut;
    }

    public static function bool(string $cle, bool $defaut = false): bool
    {
        $v = self::$valeurs[$cle] ?? null;
        return $v === null ? $defaut : in_array(strtolower($v), ['1', 'true', 'on', 'yes'], true);
    }
}
