#' Downloads dbGaPdb sqlite from temp link and unzips it
#'
#' @importsFrom R.Utils gunzip
#' @export
pull_dbGaPdb_sqlite <- function(local_path=tempdir(),
                                sqlite_db_name='dbGaPdb.sqlite.gz',
                                link='https://helix.nih.gov/~mcgaugheyd/dbGapdb.sqlite.gz'){
  path_and_file_gz <- paste0(local_path, '/', sqlite_db_name, '.gz')
  path_and_file <- paste0(local_path, '/', sqlite_db_name)
  download.file(link, path_and_file_gz)
  R.utils::gunzip(path_and_file_gz)
  return(path_and_file)
}
