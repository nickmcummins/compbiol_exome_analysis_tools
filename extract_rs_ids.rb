class ExtractRsIDs
  COLS = [:chr, :pos, :rs_id]
  COL_DELIM = "\t"
  
  attr_accessor :rs_list

  def initialize(filename)
    @rs_list = []
    extract_from_lines(filename)
  end
  
  def extract_from_lines(filename) 
    File.open(filename) do |filename|
      read_header = false
      filename.each_line do |line|
        if !read_header && !line.index("#CHROM").nil? 
          read_header = true
        else
          add_rs_id_from(line) if read_header
        end
      end
    end
  end
  
  def add_rs_id_from(line)
    rs_id = line.split(COL_DELIM)[COLS.index(:rs_id)]
    rs_list << rs_id if (!rs_id.nil? && rs_id.size > 1)
  end
  
  def print_rs_ids
    puts rs_list.join("\n")
  end
end

# main
filename = ARGV[0]
extractor = ExtractRsIDs.new(filename)
extractor.print_rs_ids
