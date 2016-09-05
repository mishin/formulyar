# formulyar
Формуляр - это мини-фреймворк для проектирования систем управления данными (DMS) с нативной графовой СУБД. 
Создан с целью обеспечить наиболее универсальный, простой и практичный способ семантического учета информации о чем-либо. Ставьте у себя формуляр, добавляйте свое решение-аватар и радуйтесь удивительным возможностям прямого взаимодействия с графовой структурой данных.

Среди других DMF отличается минимальным размером и по сути зависит от работы одного скрипта отвечающего за все компоненты MVC. В текущей версии этот коревной скрипт написан на perl (файл p/formulyar/pl/reg.pl). Еще одним отличием является приближенность к системам визуализации баз данных по примеру PHPMyAdmin для реляционной СУБД MySQl. Относительно близким аналогом формуляра можно назвать такую DMF как MarkLogic.

Система поставляется с стартовой DMS (в рамках системы синоним DMS - аватар) пригодной для простейшего учета информации, но в большинстве случаев для создания готовых сайтов или веб-приложений потребуется дополнительно спрограммировать или выбрать из готовых специализированный аватар. Помимо основного скрипта в состав фреймворка входят ряд компонентов полезных для создания аватаров: раздел администрирования, генератор web-форм и др.

Система может быть безопасно встроена в CMF (такие как Bitrix, Drupal и др.) для наиболее адекватного обслуживания задач связанных с обработкой труднотипизируемых данных. 

Наиболее важные функции, предоставляемые системой «из коробки»:
- поддержка особого формата построения графовой базы данных - m8 (вместо классического RDF);
- работа в связке с xslt-транслятором для вывода обработанных данных из базы (используется xsltproc);
- поддержика формирования pdf-файлов (используется wkhtmltopdf);
- вложенность категорий любой глубины;
- поддержка XML и JSON форматов;
- возможность создания сайтов с пересекающимся содержимым (например, общими справочниками, базой пользователей или системой администрирования);
- раздельные конфигурации сайта для различных виртуальных хостов (мультисайтинг), в том числе собственные наборы модулей и тем оформления для каждого подсайта.

Документация по формату m8 в стадии разработки. Консультации автора (ru7701@gmail.com) бесплатны.

Пожалуйста сообщайте о ошибках в трекер http://github.com/m8data/formulyar/issues. Так же добро пожаловать на форум проекта https://groups.google.com/forum/#!forum/formulyar. 

Спасибо за интерес к проекту!