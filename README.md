# Funkcinis programavimas

Modulio aprašas: [čia](http://www.mif.vu.lt/katedros/se/Sandai/13_14/C_FunkcinisProgramavimas_LT.pdf)

Email: [v.pozdniakov@gmail.com]()

Tvarkaraštis: [https://mif.vu.lt/timetable/mif/employees/viaceslav-pozdniakov/](https://mif.vu.lt/timetable/mif/employees/viaceslav-pozdniakov/)

## Svarbu

1. Pratybos 2017-10-24 18:00 ir 2017-10-25 18:00 neįvyks. Pratybos 2017-10-24 14:00 ir paskaita 2017-10-24 16:00 vyks pagal tvarkaraštį.

## Terminai

| Užduotis | Terminas (imtinai) | Pastaba                                  |
|----------|--------------------|------------------------------------------|
| 1        |         2017-10-31 | lapkričio 1 d., trečiadienis -- išeiginė |
| 2        |         2017-11-29 |                                          |
| 3        |         2017-12-20 |                                          |

## Kryžiukai-nuliukai. Žinutės struktūra

Kiekviena (ne pirma) žinutė turi lauką `prev`, kuriame yra išsaugoti visi prie tai buvusios žinutės.
Sąrašo tipo laukas `c` nurodo koordinates (sveikieji skaičiai nuo 0, 1, 2), `v` - reikšmę ("x", "X", "o", "O".), `id` - žaidėjo vardą, kuris nekinta žaidimo eigoje.

Visi raktai yra be nematomų simbolių (t.y. be tarpų, tab'ų ir pan.).

## Pavyzdys

Žinutė (kažkokiu nežinomu bet pakankamai suprantomu formatu):

~~~
(c -> [1, 1], v -> 'X', id -> 'petras', prev -> (id -> 'ruta', c -> [2, 0], v -> 'o'))
~~~

atitinka žaidimo lentą:

~~~
+-+-+-+
| | |o|
+-+-+-+
| |x| |
+-+-+-+
| | | |
+-+-+-+
~~~

## Protokolai

### Supaprastintas bencode

[https://en.wikipedia.org/wiki/Bencode]() su apribojimais: galimos tik neneigiamos sveikų skaičių reikšmės.

### Supaprastintas json

[http://json.org]() su apribojimais: sveikieji skaičiai neneigiami, be mantisės (e raidės)


## Protokolas be masyvų

Masyvą galima pakeisti žodynu, kuriame raktai -- eilutės rikiuojamos leksikografine tvarka. Tada

~~~
[1,2,'f']
~~~

tampa, pvz.,

~~~
(c -> 'f', a -> 1, b -> 2)
~~~

Kitais žodžiais, raktų reikšmės nėra svarbios, raktai tik nusako eilę, pagal kurią mes "traukiame" reikšmes iš žodyno.

## Protokolas be žodynų

Bet kurį žodyną visada galimą užrašyti kaip masyvą elementų, kuriame nelyginiai elementai yra raktai, o lyginiai -- reikšmės. Tada

~~~
(c -> 'f', a -> 1, b -> 2)
~~~

tampa, pvz.,

~~~
[ 'c', 'f', 'a', 1, 'b', 2 ]
~~~

## Nematomi simboliai

Visuose žinučių pavyzdžiuose kaip separatorius yra panaudotas vienas tarpas, bet tų tarpų gali būti ir daugiau.

## Ką galima nuveikti su užkoduota kryžiukų-nuliukų lenta

### Gintis (arba atakuoti pirmam, jei lenta yra tuščia). Signatūra:

~~~haskell
move :: String -> Either String (Maybe (Int, Int, Char))
~~~

### Nustatyti kas laimėjo. Lenta nebūtinai turi būti pilani užpildyta. Signatūra:

~~~haskell
winner :: String -> Either String (Maybe String)
~~~

## Žaidimų variacijos

Daugiau: [https://en.wikipedia.org/wiki/Tic-tac-toe_variants](https://en.wikipedia.org/wiki/Tic-tac-toe_variants)

1. Misere
2. Notakto
3. Wild Tic-Tac-Toe
4. Wild Misere

## Validavimas

Ką reikia validuoti:
1. Protokolą (ar, pvz., json yra json)
2. Ar kiekvienas langelis turi max. vieną ėjimą.

# Pirma užduotis

Atsiskaitoma GHCi aplinkoje. Eilutės tipo parametras -- tam tikro protokolo užkoduoti duomenys. Eilutėje gali būti tarpų, bet kiti nematomi simboliai (pvz., \n, \t) yra negalimi.

| Protokolas\Žaidimas        | (1) Move | (1) Winner | (2) Move | (2) Winner | (3) Move | (3) Winner | (4) Move | (4) Winner |
|----------------------------|----------|------------|----------|------------|----------|------------|----------|------------|
| bencode                    |         1|           2|         3|           4|         5|           6|         7|           8|
| json                       |         9|          10|        11|          12|        13|          14|        15|          16|
| bencode be masyvų          |        17|          18|        19|          20|        21|          22|        23|          24|
| json be masyvų             |        25|          26|        27|          28|        29|          30|        31|          32|
| bencode be žodynų          |        33|          34|        35|          36|        37|          38|        39|          40|
| json be žodynų             |        41|          42|        43|          44|        45|          46|        47|          48|

Testiniai duomenys: [http://tictactoe.haskell.lt/test/uzduoties_numeris](http://tictactoe.haskell.lt/test/uzduoties_numeris),
pvz., [http://tictactoe.haskell.lt/test/30](http://tictactoe.haskell.lt/test/30)

Programos atsiskaitymas vyksta GHCi aplinkoje: užkraunate savo sukurtą modulį, užkraunate modulį su testiniais duomenimis, iškviečiat savo funkciją su testine žinute.

## Reikalavimai

Galima naudotis tik standartinę biblioteką: modulius iš Data.*, Prelude. Žinutės nuskaitymas turi būti tvarkingas: panaudotas koks nors duomenų modelis (ADT arba prasminga tuplų/sąrašų kombinacija).

Negalima naudotis:

- teksto formatavimu pagal šabloną (printf).

- teksto "karpymu" su split funkcijomis ir pan.

- įvestimi/išvestimi (IO)
